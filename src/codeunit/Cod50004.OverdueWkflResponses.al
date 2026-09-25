codeunit 50004 "Overdue Wkfl. Responses"
{
    // ============================================================
    // RESPONSE CODES
    // CheckOverdueToleranceCode mirrors the standard
    // CheckCustomerCreditLimitCode response.
    // ============================================================
    procedure CheckOverdueToleranceCode(): Code[128]begin
        exit('MECH-CHECK-OVERDUE-TOLERANCE');
    end;
    procedure MarkOverdueToleranceApprovedCode(): Code[128]begin
        exit('MECH-MARK-OVERDUE-APPROVED');
    end;
    // ============================================================
    // ADD RESPONSES TO THE WORKFLOW RESPONSE LIBRARY
    // ============================================================
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    local procedure OnAddWorkflowResponsesToLibrary()
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        WorkflowResponseHandling.AddResponseToLibrary(CheckOverdueToleranceCode(), 0, CheckOverdueToleranceTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(MarkOverdueToleranceApprovedCode(), Database::"Sales Header", MarkOverdueToleranceApprovedTxt, 'GROUP 0');
    end;
    // ============================================================
    // RESPONSE PREDECESSORS
    // - CheckOverdueTolerance runs right after "Sales document sent
    //   for approval" - exactly like CheckCustomerCreditLimitCode.
    // - "Create an approval request" is set as the user's chosen
    //   response to the "Overdue Tolerance Exceeded" EVENT itself
    //   (configured on the Workflows page), same as Credit Limit.
    // - MarkOverdueToleranceApproved runs once the approval request
    //   raised by that event is approved.
    // ============================================================
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        case ResponseFunctionName of CheckOverdueToleranceCode(): WorkflowResponseHandling.AddResponsePredecessor(CheckOverdueToleranceCode(), WorkflowEventHandling.RunWorkflowOnSendSalesDocForApprovalCode());
        MarkOverdueToleranceApprovedCode(): WorkflowResponseHandling.AddResponsePredecessor(MarkOverdueToleranceApprovedCode(), WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode());
        end;
    end;
    // ============================================================
    // EXECUTE RESPONSES
    // ============================================================
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    local procedure OnExecuteWorkflowResponse(var ResponseExecuted: Boolean; var Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        if not WorkflowResponse.Get(ResponseWorkflowStepInstance."Function Name")then exit;
        case WorkflowResponse."Function Name" of CheckOverdueToleranceCode(): begin
            CheckOverdueTolerance(Variant);
            ResponseExecuted:=true;
        end;
        MarkOverdueToleranceApprovedCode(): ResponseExecuted:=MarkOverdueToleranceApproved(Variant);
        end;
    end;
    // ------------------------------------------------------------
    // "Check Overdue Tolerance" - mirrors
    // WorkflowResponseHandling.CheckCustomerCreditLimit(Variant),
    // which calls SalesHeader.CheckAvailableCreditLimit().
    // Here we run our own check and raise the matching event.
    // ------------------------------------------------------------
    local procedure CheckOverdueTolerance(Variant: Variant)
    var
        SalesHeader: Record "Sales Header";
        OverdueApprovalMgt: Codeunit "Overdue Approval Mgt.";
        OverdueWkflEvents: Codeunit "Overdue Wkfl. Events";
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        if RecRef.Number <> Database::"Sales Header" then exit;
        SalesHeader:=Variant;
        // if OverdueApprovalMgt.IsOverdueApprovalRequired(SalesHeader) then
        //     OverdueWkflEvents.RunWorkflowOnOverdueToleranceExceeded(SalesHeader)
        // else
        //     OverdueWkflEvents.RunWorkflowOnOverdueToleranceNotExceeded(SalesHeader);
        //shama
        if OverdueApprovalMgt.IsOverdueApprovalRequired(SalesHeader)then begin
            SalesHeader."Overdue Tolernce Aprv Required":=true;
            SalesHeader."Overdue Tolerance Approved":=false;
            SalesHeader.Modify(true);
            OverdueWkflEvents.RunWorkflowOnOverdueToleranceExceeded(SalesHeader);
        end
        else
        begin
            SalesHeader."Overdue Tolernce Aprv Required":=false;
            SalesHeader."Overdue Tolerance Approved":=false;
            SalesHeader.Modify(true);
            OverdueWkflEvents.RunWorkflowOnOverdueToleranceNotExceeded(SalesHeader);
        end;
    //shama
    end;
    // ------------------------------------------------------------
    // "Mark Overdue Tolerance Approved" - runs once the approval
    // request created for the "Exceeded" event has been approved.
    // ------------------------------------------------------------
    local procedure MarkOverdueToleranceApproved(Variant: Variant)Handled: Boolean var
        ApprovalEntry: Record "Approval Entry";
        SalesHeader: Record "Sales Header";
        RecordRef: RecordRef;
    begin
        RecordRef.GetTable(Variant);
        if RecordRef.Number <> Database::"Approval Entry" then exit(false);
        ApprovalEntry:=Variant;
        if not RecordRef.Get(ApprovalEntry."Record ID to Approve")then exit(false);
        if RecordRef.Number <> Database::"Sales Header" then exit(false);
        RecordRef.SetTable(SalesHeader);
        // Only mark the Sales Order if THIS Sales Order
        // was actually waiting for overdue tolerance approval.
        if not SalesHeader."Overdue Tolernce Aprv Required" then exit(false);
        SalesHeader."Overdue Tolerance Approved":=true;
        SalesHeader."Overdue Tolernce Aprv Required":=false;
        SalesHeader.Modify(true);
        exit(true);
    end;
    var CheckOverdueToleranceTxt: Label 'Check if the sales document has exceeded the customer''s overdue days tolerance.';
    MarkOverdueToleranceApprovedTxt: Label 'Mark overdue tolerance approval as approved.';
}

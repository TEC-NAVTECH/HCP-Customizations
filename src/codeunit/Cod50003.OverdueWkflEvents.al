codeunit 50003 "Overdue Wkfl. Events"
{
    // ============================================================
    // EVENT CODES
    // Mirrors standard "Customer Credit Limit Exceeded / Not Exceeded"
    // events (see WorkflowEventHandling.Codeunit.al in Base App).
    // ============================================================
    procedure RunWorkflowOnOverdueToleranceExceededCode(): Code[128]begin
        exit('RUNWORKFLOWONOVERDUETOLERANCEEXCEEDED');
    end;
    procedure RunWorkflowOnOverdueToleranceNotExceededCode(): Code[128]begin
        exit('RUNWORKFLOWONOVERDUETOLERANCENOTEXCEEDED');
    end;
    // ============================================================
    // REGISTER EVENTS TO THE WORKFLOW EVENT LIBRARY
    // (shows up in the Workflows page event dropdown, same table as
    // the standard Credit Limit events: Sales Header)
    // ============================================================
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnOverdueToleranceExceededCode(), Database::"Sales Header", OverdueToleranceExceededTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnOverdueToleranceNotExceededCode(), Database::"Sales Header", OverdueToleranceNotExceededTxt, 0, false);
    end;
    // ============================================================
    // EVENT PREDECESSOR
    // Both events can only fire after the standard "Sales document
    // sent for approval" event - exactly like the Credit Limit events.
    // ============================================================
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        case EventFunctionName of RunWorkflowOnOverdueToleranceExceededCode(): WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnOverdueToleranceExceededCode(), WorkflowEventHandling.RunWorkflowOnSendSalesDocForApprovalCode());
        RunWorkflowOnOverdueToleranceNotExceededCode(): WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnOverdueToleranceNotExceededCode(), WorkflowEventHandling.RunWorkflowOnSendSalesDocForApprovalCode());
        end;
    end;
    // ============================================================
    // RAISE THE EVENTS (called from the "Check Overdue Tolerance"
    // response in Cod50103 - mirrors SalesHeader.CustomerCreditLimit-
    // Exceeded()/NotExceeded() calling WorkflowManagement.HandleEvent)
    // ============================================================
    procedure RunWorkflowOnOverdueToleranceExceeded(var SalesHeader: Record "Sales Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnOverdueToleranceExceededCode(), SalesHeader);
    end;
    procedure RunWorkflowOnOverdueToleranceNotExceeded(var SalesHeader: Record "Sales Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnOverdueToleranceNotExceededCode(), SalesHeader);
    end;
    var OverdueToleranceExceededTxt: Label 'The sales document has exceeded the customer''s overdue days tolerance.';
    OverdueToleranceNotExceededTxt: Label 'The sales document has not exceeded the customer''s overdue days tolerance.';
}

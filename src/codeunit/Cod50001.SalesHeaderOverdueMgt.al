codeunit 50001 "Sales Header Overdue Mgt."
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Customer No.', false, false)]
    local procedure OnAfterValidateSellToCustomerNo(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        Customer: Record Customer;
    begin
        Rec."Overdue Tolerance Approved" := false;
        Rec."Overdue Tolernce Aprv Required" := false;
        if Rec."Sell-to Customer No." = '' then begin
            clear(Rec."Overdue Days Tolerance");
            exit;
        end;
        if Customer.Get(Rec."Sell-to Customer No.") then Rec."Overdue Days Tolerance" := Customer."Overdue Days Tolerance";
    end;

    [EventSubscriber(ObjectType::Report, report::"Get Source Documents", OnAfterCreateShptHeader, '', false, false)]
    local procedure OnAfterCreateShptHeader(var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; WarehouseRequest: Record "Warehouse Request"; SalesLine: Record "Sales Line")
    var
        salesHeader: Record "Sales Header";
    begin
        if salesline."Document Type" <> salesHeader."Document Type"::Order then exit;
        if not salesHeader.Get(salesline."Document Type", salesline."Document No.") then exit;
        warehouseShipmentHeader."Preorder Sales Order Status" := salesHeader."Preorder Sales Order Status";
        warehouseShipmentHeader.Modify();
    end;

    // ON REOPEN SALES ORDER

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReopenSalesDoc', '', false, false)]
    local procedure OnAfterReopenSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; SkipWhseRequestOperations: Boolean)
    begin
        if PreviewMode then exit;
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then exit;

        CancelOpenApprovalEntries(SalesHeader);

        SalesHeader."Overdue Tolerance Approved" := false;
        SalesHeader."Overdue Tolernce Aprv Required" := false;
        SalesHeader.Modify(true);
    end;

    // Cancels any Approval Entry still in Open status that points
    local procedure CancelOpenApprovalEntries(SalesHeader: Record "Sales Header")
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.SetRange("Table ID", Database::"Sales Header");
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SetRange("Record ID to Approve", SalesHeader.RecordId);
        if ApprovalEntry.FindSet(true) then
            repeat
                ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                ApprovalEntry."Last Date-Time Modified" := CurrentDateTime;
                ApprovalEntry.Modify();
            until ApprovalEntry.Next() = 0;
    end;

    //"CANCEL APPROVAL REQUEST" ACTION
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelSalesApprovalRequest', '', false, false)]
    local procedure OnCancelSalesApprovalRequest(var SalesHeader: Record "Sales Header")
    var
        SalesHeaderToUpdate: Record "Sales Header";
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then exit;
        if not SalesHeaderToUpdate.Get(SalesHeader."Document Type", SalesHeader."No.") then exit;

        SalesHeaderToUpdate."Overdue Tolerance Approved" := false;
        SalesHeaderToUpdate."Overdue Tolernce Aprv Required" := false;
        SalesHeaderToUpdate.Modify(true);

        SalesHeader := SalesHeaderToUpdate;
    end;
}

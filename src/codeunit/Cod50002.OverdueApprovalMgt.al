codeunit 50002 "Overdue Approval Mgt."
{
    procedure IsOverdueApprovalRequired(SalesHeader: Record "Sales Header"): Boolean
    var
        Customer: Record Customer;
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then exit(false);
        if SalesHeader."Due Date" = 0D then exit(false);
        if not Customer.Get(SalesHeader."Sell-to Customer No.") then exit(false);
        if Today > CalcDate(SalesHeader."Overdue Days Tolerance", SalesHeader."Due Date") then exit(true);

        exit(HasOverdueCustomerLedgerEntry(Customer."No.", ToleranceDaysAsInteger(Customer."Overdue Days Tolerance")));
    end;

    // CONVERT DateFormula -> Integer (number of days from Today)
    local procedure ToleranceDaysAsInteger(OverdueDaysTolerance: DateFormula): Integer
    begin
        exit(CalcDate(OverdueDaysTolerance, Today) - Today);
    end;
    // CUSTOMER LEDGER ENTRY CHECK
    local procedure HasOverdueCustomerLedgerEntry(CustomerNo: Code[20]; OverdueDaysTolerance: Integer): Boolean
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgerEntry.Reset();
        CustLedgerEntry.SetCurrentKey("Customer No.");
        CustLedgerEntry.SetRange("Customer No.", CustomerNo);
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SetFilter("Remaining Amount", '<>%1', 0);
        CustLedgerEntry.SetRange(Open, true);
        CustLedgerEntry.SetFilter("Due Date", '<%1', Today - OverdueDaysTolerance);
        if CustLedgerEntry.FindFirst() then
            exit(true);

        exit(false);
    end;
}

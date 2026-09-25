pageextension 50009 "Posted Sales Invs. Combined" extends "Posted Sales Invoices"
{
    actions
    {
        addlast(processing)
        {
            action(PrintCombinedInvoice)
            {
                Caption = 'Print Combined Invoice';
                ApplicationArea = All;
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Prints every layout of the chosen Invoice Type for the selected documents in one job.';

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    Report.RunModal(Report::"Combined Sales Invoice", true, false, SalesInvHeader);
                end;
            }
        }
    }
}

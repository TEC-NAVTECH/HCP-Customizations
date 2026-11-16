pageextension 50008 "Posted Sales Inv. Combined" extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Due Date")
        {

            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cargo Receipt Remarks field.', Comment = '%';
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action(PrintCombinedInvoice)
            {
                Caption = 'Print HCP Combined Invoice';
                ApplicationArea = All;
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Prints every layout of the chosen Invoice Type for this document in one job.';

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    SalesInvHeader := Rec;
                    SalesInvHeader.SetRecFilter();
                    Report.RunModal(Report::"HCP Combined Sales Invoice", true, false, SalesInvHeader);
                end;
            }
        }
    }
}

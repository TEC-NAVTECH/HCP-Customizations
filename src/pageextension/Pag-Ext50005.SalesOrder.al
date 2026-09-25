pageextension 50005 "Sales Order" extends "Sales Order"
{
    layout
    {
        addlast(General)
        {
            field("Overdue Days Tolerance"; Rec."Overdue Days Tolerance")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the overdue days tolerance copied from the customer. Used automatically when the sales document is sent for approval.';
            }
            field("Overdue Tolerance Approval Required"; Rec."Overdue Tolernce Aprv Required")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies whether the overdue tolerance approval, triggered automatically on Send Approval Request, has been required.';
            }
            field("Overdue Tolerance Approved"; Rec."Overdue Tolerance Approved")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies whether the overdue tolerance approval, triggered automatically on Send Approval Request, has been approved.';
            }
        }
        addafter(Status)
        {
            field("Preorder Sales Order Status"; Rec."Preorder Sales Order Status")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the preorder sales order status, copied from the customer. Used automatically when the sales document is sent for approval.';
            }
        }
    }
// No manual "Send for Approval" action anymore - the overdue
// tolerance check now runs automatically as part of the standard
// "Send Approval Request" action, exactly like the Credit Limit
// Approval Workflow (see Cod50103 "Overdue Wkfl. Responses").
}

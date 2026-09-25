tableextension 50005 "Sales Header" extends "Sales Header"
{
    fields
    {
        field(50000; "Overdue Days Tolerance"; DateFormula)
        {
            Caption = 'Overdue Days Tolerance';
            DataClassification = CustomerContent;
        }
        field(50001; "Overdue Tolerance Approved"; Boolean)
        {
            Caption = 'Overdue Tolerance Approved';
            DataClassification = CustomerContent;
        }
        field(50002; "Overdue Tolernce Aprv Required"; Boolean)
        {
            Caption = 'Overdue Tolerance Approval Required';
            DataClassification = CustomerContent;
        }
        field(50003; "Preorder Sales Order Status"; Option)
        {
            Caption = 'Preorder Sales Order Status';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Not Confirmed","Confirmed";
        }
    }
}

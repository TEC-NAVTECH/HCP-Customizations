tableextension 50009 SalesInvHeaderExt extends "Sales Invoice Header"
{
    fields
    {
        field(50004; Remarks; Code[20])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
            tableRelation = Remarks.Code;
        }
    }
}

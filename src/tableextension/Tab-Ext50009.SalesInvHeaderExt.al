tableextension 50009 SalesInvHeaderExt extends "Sales Invoice Header"
{
    fields
    {
        field(50004; "Cargo Receipt Remarks"; Text[50])
        {
            Caption = 'Cargo Receipt Remarks';
            DataClassification = CustomerContent;
        }
    }
}

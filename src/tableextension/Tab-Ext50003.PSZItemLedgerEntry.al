tableextension 50003 "PSZ Item Ledger Entry" extends "Item Ledger Entry"
{
    fields
    {
        field(50100; "Packing Size"; text[30])
        {
            Caption = 'Packing Size';
            DataClassification = CustomerContent;
        }
    }
}

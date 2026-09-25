tableextension 50001 "PSZ Reservation Entry" extends "Reservation Entry"
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

tableextension 50002 "PSZ Item Journal Line" extends "Item Journal Line"
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

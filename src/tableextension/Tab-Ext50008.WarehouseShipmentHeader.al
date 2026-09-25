tableextension 50008 "Warehouse Shipment Header" extends "Warehouse Shipment Header"
{
    fields
    {
        field(50001; Label; text[100])
        {
            caption = 'Label';
            DataClassification = ToBeClassified;
        }
        field(50002; Quantity; text[100])
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(50003; "Preorder Sales Order Status"; Option)
        {
            Caption = 'Preorder Sales Order Status';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Not Confirmed","Confirmed";
        }
    }
}

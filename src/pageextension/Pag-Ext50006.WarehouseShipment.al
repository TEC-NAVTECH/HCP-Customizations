pageextension 50006 "Warehouse Shipment" extends "Warehouse Shipment"
{
    layout
    {
        addafter("Sorting method")
        {
            field(Label; Rec.Label)
            {
                ApplicationArea = All;
            }
            field(Quantity; Rec.Quantity)
            {
                ApplicationArea = All;
            }
            field("Preorder Sales Order Status"; Rec."Preorder Sales Order Status")
            {
                ApplicationArea = All;
                editable = false;
            }
        }
    }
}

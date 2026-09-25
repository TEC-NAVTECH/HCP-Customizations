pageextension 50002 PostedItemTrackingLines extends "Posted Item Tracking Lines"
{
    layout
    {
        addafter("Package No.")
        {
            field("Packing Size"; Rec."Packing Size")
            {
                ApplicationArea = All;
            }
        }
    }
}

pageextension 50001 ItemLedgerEntriesExt extends "Item Ledger Entries"
{
    layout
    {
        modify("Lot No.")
        {
            visible = true;
        }
        addafter("Lot No.")
        {
            field("Packing Size"; Rec."Packing Size")
            {
                ApplicationArea = All;
            }
        }
    }
}

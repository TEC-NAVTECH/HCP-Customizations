pageextension 50000 "PSZ Item Tracking Lines" extends "Item Tracking Lines"
{
    layout
    {
        addafter("Package No.")
        {
            field("Packing Size"; Rec."Packing Size")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the packing size for this tracking line.';

                trigger onvalidate()
                var
                    ReservEntry: Record "Reservation Entry";
                begin
                    ReservEntry.SetRange("Source Type", Rec."Source Type");
                    ReservEntry.SetRange("Source Subtype", Rec."Source Subtype");
                    ReservEntry.SetRange("Source ID", Rec."Source ID");
                    ReservEntry.SetRange("Source Ref. No.", Rec."Source Ref. No.");
                    ReservEntry.SetRange("Source Prod. Order Line", Rec."Source Prod. Order Line");
                    ReservEntry.SetRange("Serial No.", Rec."Serial No.");
                    ReservEntry.SetRange("Lot No.", Rec."Lot No.");
                    ReservEntry.SetRange("Package No.", Rec."Package No.");
                    if ReservEntry.FindSet(true)then repeat ReservEntry."Packing Size":=Rec."Packing Size";
                            ReservEntry.Modify();
                        until ReservEntry.Next() = 0;
                end;
            }
        }
    }
}

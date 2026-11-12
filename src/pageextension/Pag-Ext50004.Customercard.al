pageextension 50004 "Customer card" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Overdue Days Tolerance"; Rec."Overdue Days Tolerance")
            {
                ApplicationArea = All;
            }
        }
        addafter(city)
        {
            field(Territorycode; Rec."Territory Code")
            {
                ApplicationArea = All;
            }
        }
    }
}

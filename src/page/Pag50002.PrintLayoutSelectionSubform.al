page 50002 "Print Layout Selection Subform"
{
    Caption = 'Layouts';
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Print Layout Selection Line";
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Layout No."; Rec."Layout No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the layout printed at this position (1-6).';
                }
                field("Layout Name"; Rec."Layout Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the layout.';
                }
            }
        }
    }
}

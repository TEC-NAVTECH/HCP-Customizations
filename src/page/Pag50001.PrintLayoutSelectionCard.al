page 50001 "Print Layout Selection Card"
{
    Caption = 'Print Layout Selections';
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Print Layout Selection";

    //  CardPageId = "Print Layout Selection Card";
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Invoice Type code.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description.';
                }
                field("Layout Ordering"; Rec."Layout Ordering")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies which layouts print, in print order.';
                }
            }
            part(Lines; "Print Layout Selection Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Selection Code"=field("Code");
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(EditLayouts)
            {
                Caption = 'Layouts';
                ApplicationArea = All;
                Image = Line;
                ToolTip = 'Set up which layouts print for this Invoice Type, and in what order.';
                RunObject = page "Print Layout Selection Lines";
                RunPageLink = "Selection Code"=field("Code");
            }
            action(InsertDefaults)
            {
                Caption = 'Insert Default Invoice Types';
                ApplicationArea = All;
                Image = Setup;
                ToolTip = 'Creates the standard Invoice Types and their layout ordering.';

                trigger OnAction()
                var
                    Setup: Codeunit "Print Layout Setup";
                begin
                    Setup.InsertDefaults();
                    CurrPage.Update(false);
                end;
            }
        }
    }
}

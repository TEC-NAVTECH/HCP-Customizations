page 50004 "Item Ledger Entries Edit"
{
    ApplicationArea = All;
    Caption = 'Item Ledger Entries Edit';
    PageType = List;
    SourceTable = "Item Ledger Entry";
    UsageCategory = Lists;
    permissions = tabledata "Item Ledger Entry" = RM;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the posting date for the entry.';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ToolTip = 'Specifies which type of transaction the entry is created from.';
                }
                field("Source No."; Rec."Source No.")
                {
                    ToolTip = 'Shows where the entry originated. If the entry was posted from an item journal line, the field will be empty. If the entry was posted from an purchase order, purchase invoice or purchase credit memo, the field displays the buy-from vendor number. If it is posted from sales the sell-to customer number will be displayed.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ToolTip = 'Specifies the value of the Expiration Date field.', Comment = '%';
                    Editable = true;
                }
            }
        }
    }
}

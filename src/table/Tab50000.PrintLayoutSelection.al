table 50000 "Print Layout Selection"
{
    Caption = 'Print Layout Selection';
    DataClassification = CustomerContent;
    LookupPageId = "Print Layout Selections";
    DrillDownPageId = "Print Layout Selections";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Layout Ordering"; Text[50])
        {
            Caption = 'Layout Ordering';
            Editable = false;
            FieldClass = Normal;
            DataClassification = CustomerContent;
        // Denormalised "1,2,6,3,4,5" for display only; maintained by
        // table 50101 so the setup list reads like the customer's sheet.
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description, "Layout Ordering")
        {
        }
    }
    trigger OnDelete()
    var
        SelLine: Record "Print Layout Selection Line";
    begin
        SelLine.SetRange("Selection Code", Code);
        SelLine.DeleteAll();
    end;
    procedure UpdateLayoutOrdering()
    var
        SelLine: Record "Print Layout Selection Line";
        NewOrdering: Text;
    begin
        SelLine.SetCurrentKey("Selection Code", "Line No.");
        SelLine.SetRange("Selection Code", Code);
        if SelLine.FindSet()then repeat if NewOrdering <> '' then NewOrdering+=',';
                NewOrdering+=Format(SelLine."Layout No.");
            until SelLine.Next() = 0;
        if "Layout Ordering" = CopyStr(NewOrdering, 1, MaxStrLen("Layout Ordering"))then exit;
        "Layout Ordering":=CopyStr(NewOrdering, 1, MaxStrLen("Layout Ordering"));
        Modify();
    end;
}

table 50001 "Print Layout Selection Line"
{
    Caption = 'Print Layout Selection Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Selection Code"; Code[20])
        {
            Caption = 'Selection Code';
            TableRelation = "Print Layout Selection".Code;
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Layout No."; Integer)
        {
            Caption = 'Layout No.';
            MinValue = 1;
            MaxValue = 6;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Layout Name":=CopyStr(LayoutName("Layout No."), 1, MaxStrLen("Layout Name"));
            end;
        }
        field(4; "Layout Name"; Text[50])
        {
            Caption = 'Layout Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Selection Code", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        UpdateHeader();
    end;
    trigger OnModify()
    begin
        UpdateHeader();
    end;
    trigger OnDelete()
    begin
        UpdateHeader();
    end;
    local procedure UpdateHeader()
    var
        Sel: Record "Print Layout Selection";
    begin
        if Sel.Get("Selection Code")then Sel.UpdateLayoutOrdering();
    end;
    procedure LayoutName(LayoutNo: Integer): Text begin
        case LayoutNo of 1: exit('Cargo Receipt');
        2: exit('Pharmaceutical Product');
        3: exit('Poison');
        4: exit('Original');
        5: exit('Warehouse');
        6: exit('Order Form');
        end;
        exit('');
    end;
}

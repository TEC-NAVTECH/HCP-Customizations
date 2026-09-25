table 50003 "Invoice Print Line Buffer"
{
    Caption = 'Invoice Print Line Buffer';
    DataClassification = SystemMetadata;
    TableType = Temporary;

    fields
    {
        field(1; "Row No."; Integer)
        {
            Caption = 'Row No.';
        }
        field(2; "Row Type"; Integer)
        {
            Caption = 'Row Type';
        }
        field(3; "Line No. Text"; Text[10])
        {
            Caption = 'Line No. Text';
        }
        field(4; "Product Code"; Text[50])
        {
            Caption = 'Product Code';
        }
        field(5; "Product Code 2"; Text[50])
        {
            Caption = 'Product Code 2';
        }
        field(6; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(7; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
        }
        field(8; "UOM Text"; Text[20])
        {
            Caption = 'UOM Text';
        }
        field(9; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(10; Amount; Decimal)
        {
            Caption = 'Amount';
        }
    }
    keys
    {
        key(PK; "Row No.")
        {
            Clustered = true;
        }
    }
}

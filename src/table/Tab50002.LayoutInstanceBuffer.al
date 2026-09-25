table 50002 "Layout Instance Buffer"
{
    Caption = 'Layout Instance Buffer';
    DataClassification = SystemMetadata;
    TableType = Temporary;

    fields
    {
        field(1; "Sequence No."; Integer)
        {
            Caption = 'Sequence No.';
        }
        field(2; "Layout No."; Integer)
        {
            Caption = 'Layout No.';
        }
        field(3; "Document Title"; Text[30])
        {
            Caption = 'Document Title';
        } // INVOICE / ORDER FORM
        field(4; "Sold-To Label"; Text[30])
        {
            Caption = 'Sold-To Label';
        } // SOLD TO : / Order by :
        field(5; "Stamp Caption"; Text[50])
        {
            Caption = 'Stamp Caption';
        } // CARGO RECEIPT
        field(6; "Stamp Number"; Text[10])
        {
            Caption = 'Stamp Number';
        } // (1)
        field(7; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
        }
        field(10; "Show Pricing"; Boolean)
        {
            Caption = 'Show Pricing';
        } // unit price + amount columns
        field(11; "Show Order Form Style"; Boolean)
        {
            Caption = 'Show Order Form Style';
        }
        field(12; "Show Signature Block"; Boolean)
        {
            Caption = 'Show Signature Block';
        }
        field(13; "Show Total Box"; Boolean)
        {
            Caption = 'Show Total Box';
        }
        field(14; "Show Total Value"; Boolean)
        {
            Caption = 'Show Total Value';
        }
        field(15; "Stamp Boxed"; Boolean)
        {
            Caption = 'Stamp Boxed';
        }
        field(16; "Suppress Page Break"; Boolean)
        {
            Caption = 'Suppress Page Break';
        }
    }
    keys
    {
        key(PK; "Sequence No.")
        {
            Clustered = true;
        }
    }
}

tableextension 50007 "G/L Setup Print Symbol" extends "General Ledger Setup"
{
    fields
    {
        field(50100; "LCY Print Symbol"; Text[20])
        {
            Caption = 'LCY Print Symbol';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the symbol printed on invoices for documents in local currency, for example HK$.';
        }
    }
}

tableextension 50006 "Currency Print Symbol" extends Currency
{
    fields
    {
        field(50100; "Print Symbol"; Text[20])
        {
            Caption = 'Print Symbol';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the symbol printed on invoices for this currency, for example HK$.';
        }
    }
}

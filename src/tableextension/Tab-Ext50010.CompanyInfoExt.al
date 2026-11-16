tableextension 50010 "Company Info Ext" extends "Company Information"
{
    fields
    {
        field(50100; "Company chinese Name"; Text[50])
        {
            Caption = 'Company Chinese Name';
            DataClassification = CustomerContent;
        }
    }
}

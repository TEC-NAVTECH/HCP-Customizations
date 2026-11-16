pageextension 50007 "Company Information Ext" extends "Company Information"
{
    layout
    {
        addafter("Name")
        {
            field("Company chinese Name"; Rec."Company chinese Name")
            {
                ApplicationArea = All;
            }
        }
    }
}

tableextension 50004 Customer extends Customer
{
    fields
    {
        field(50000; "Overdue Days Tolerance"; DateFormula)
        {
            Caption = 'Overdue Days Tolerance';
            DataClassification = CustomerContent;
        }
    }
}

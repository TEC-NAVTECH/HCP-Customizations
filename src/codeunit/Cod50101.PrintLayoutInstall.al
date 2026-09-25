codeunit 50101 "Print Layout Install"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        Setup: Codeunit "Print Layout Setup";
        Sel: Record "Print Layout Selection";
    begin
        if Sel.IsEmpty()then Setup.InsertDefaults();
    end;
}

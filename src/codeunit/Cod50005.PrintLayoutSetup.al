codeunit 50005 "Print Layout Setup"
{
    // Seeds the Invoice Types from the customer's sheet.
    // Layout catalogue: 1 Cargo Receipt, 2 Pharmaceutical Product, 3 Poison,
    //                   4 Original, 5 Warehouse, 6 Order Form.
    procedure InsertDefaults()
    begin
        AddSelection('OTC', 'Invoice for OTC', '1,2,6,3,4,5');
        AddSelection('GOVERNMENT', 'Invoice for Government', '1,2,3,4,5');
        AddSelection('DOCTOR', 'Invoice for Doctor', '1,2,3,6,4,5');
        AddSelection('NOPOISON', 'Invoice without Poison', '1,2,6,4,5');
        AddSelection('CARGO', 'Cargo Receipt', '1');
        AddSelection('PHARMA', 'Pharmaceutical Product', '2');
        AddSelection('POISON', 'Poison', '3');
        AddSelection('ORIGINAL', 'Original', '4');
        AddSelection('WAREHOUSE', 'Warehouse', '5');
        AddSelection('ORDERFORM', 'Order Form', '6');
    end;
    local procedure AddSelection(SelCode: Code[20]; SelDescription: Text[100]; Ordering: Text)
    var
        Sel: Record "Print Layout Selection";
        SelLine: Record "Print Layout Selection Line";
        Parts: List of[Text];
        Part: Text;
        LineNo: Integer;
        LayoutNo: Integer;
    begin
        if not Sel.Get(SelCode)then begin
            Sel.Init();
            Sel.Code:=SelCode;
            Sel.Description:=SelDescription;
            Sel.Insert();
        end;
        SelLine.SetRange("Selection Code", SelCode);
        if not SelLine.IsEmpty()then exit; // never overwrite an ordering somebody has edited
        Parts:=Ordering.Split(',');
        foreach Part in Parts do if Evaluate(LayoutNo, Part)then begin
                LineNo+=10000;
                SelLine.Init();
                SelLine."Selection Code":=SelCode;
                SelLine."Line No.":=LineNo;
                SelLine.Validate("Layout No.", LayoutNo);
                SelLine.Insert(true);
            end;
        Sel.Get(SelCode);
        Sel.UpdateLayoutOrdering();
    end;
}

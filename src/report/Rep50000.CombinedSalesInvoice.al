report 50000 "Combined Sales Invoice"
{
    Caption = 'Combined Sales Invoice';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    PreviewMode = PrintLayout;
    DefaultRenderingLayout = CombinedInvoiceRdlc;

    dataset
    {
        dataitem(Header; "Sales Invoice Header")
        {
            RequestFilterFields = "No.", "Sell-to Customer No.", "Posting Date";

            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Name2; CompanyInfo."Name 2")
            {
            }
            column(CompanyInfo_AddressText; CompanyAddressText)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Header_No; "No.")
            {
            }
            column(Header_DocumentDate; "Document Date")
            {
            }
            column(Header_SoldToText; SoldToText)
            {
            }
            column(Header_ShipToText; ShipToText)
            {
            }
            column(Header_PhoneNo; PhoneNoText)
            {
            }
            column(Header_OrderNo; OrderNoText)
            {
            }
            column(Header_CustomerNo; "Sell-to Customer No.")
            {
            }
            column(Header_SalespersonCode; "Salesperson Code")
            {
            }
            column(Header_PORef; "External Document No.")
            {
            }
            column(Header_ShipmentDate; "Shipment Date")
            {
            }
            column(Header_PaymentTerms; PaymentTermsText)
            {
            }
            column(Header_DueDate; "Due Date")
            {
            }
            column(Header_CurrencyCode; CurrencySymbolText)
            {
            }
            column(Header_WorkDescription; WorkDescriptionText)
            {
            }
            dataitem(LayoutInstance; Integer)
            {
                DataItemTableView = sorting(Number);

                column(LayoutInstance_SequenceNo; TempLayoutInstance."Sequence No.")
                {
                }
                column(LayoutInstance_LayoutNo; TempLayoutInstance."Layout No.")
                {
                }
                column(LayoutInstance_DocTitle; TempLayoutInstance."Document Title")
                {
                }
                column(LayoutInstance_SoldToLabel; TempLayoutInstance."Sold-To Label")
                {
                }
                column(LayoutInstance_StampCaption; TempLayoutInstance."Stamp Caption")
                {
                }
                column(LayoutInstance_StampNumber; TempLayoutInstance."Stamp Number")
                {
                }
                column(LayoutInstance_TotalAmount; TempLayoutInstance."Total Amount")
                {
                }
                column(LayoutInstance_ShowPricing; TempLayoutInstance."Show Pricing")
                {
                }
                column(LayoutInstance_ShowOrderForm; TempLayoutInstance."Show Order Form Style")
                {
                }
                column(LayoutInstance_ShowSignature; TempLayoutInstance."Show Signature Block")
                {
                }
                column(LayoutInstance_ShowTotalBox; TempLayoutInstance."Show Total Box")
                {
                }
                column(LayoutInstance_ShowTotalValue; TempLayoutInstance."Show Total Value")
                {
                }
                column(LayoutInstance_StampBoxed; TempLayoutInstance."Stamp Boxed")
                {
                }
                column(LayoutInstance_SuppressPageBreak; TempLayoutInstance."Suppress Page Break")
                {
                }
                dataitem(PrintLine; Integer)
                {
                    DataItemTableView = sorting(Number);

                    column(PrintLine_RowNo; TempPrintLine."Row No.")
                    {
                    }
                    column(PrintLine_RowType; TempPrintLine."Row Type")
                    {
                    }
                    column(PrintLine_LineNoText; TempPrintLine."Line No. Text")
                    {
                    }
                    column(PrintLine_ProductCode; TempPrintLine."Product Code")
                    {
                    }
                    column(PrintLine_ProductCode2; TempPrintLine."Product Code 2")
                    {
                    }
                    column(PrintLine_Description; TempPrintLine.Description)
                    {
                    }
                    column(PrintLine_UnitPrice; TempPrintLine."Unit Price")
                    {
                    }
                    column(PrintLine_UomText; TempPrintLine."UOM Text")
                    {
                    }
                    column(PrintLine_Quantity; TempPrintLine.Quantity)
                    {
                    }
                    column(PrintLine_Amount; TempPrintLine.Amount)
                    {
                    }
                    trigger OnPreDataItem()
                    begin
                        TempPrintLine.Reset();
                        SetRange(Number, 1, TempPrintLine.Count());
                    end;
                    trigger OnAfterGetRecord()
                    begin
                        if Number = 1 then TempPrintLine.FindSet()
                        else
                            TempPrintLine.Next();
                    end;
                }
                trigger OnPreDataItem()
                begin
                    TempLayoutInstance.Reset();
                    SetRange(Number, 1, TempLayoutInstance.Count());
                end;
                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then TempLayoutInstance.FindSet()
                    else
                        TempLayoutInstance.Next();
                    BuildPrintLines(TempLayoutInstance."Layout No.");
                end;
            }
            trigger OnAfterGetRecord()
            begin
                BuildDocumentTexts();
                BuildLayoutInstances();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(PrintOptions)
                {
                    Caption = 'Print Options';

                    field(PrintLayoutSelectionCodeCtrl; PrintLayoutSelectionCode)
                    {
                        Caption = 'Invoice Type';
                        ApplicationArea = All;
                        TableRelation = "Print Layout Selection".Code;
                        ToolTip = 'Specifies which layouts are printed for each invoice, and in what order.';

                        trigger OnValidate()
                        begin
                            DescribeSelection();
                        end;
                    }
                    field(SelectionDescriptionCtrl; SelectionDescription)
                    {
                        Caption = 'Description';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(SelectionOrderingCtrl; SelectionOrdering)
                    {
                        Caption = 'Layout Ordering';
                        ApplicationArea = All;
                        Editable = false;
                        ToolTip = 'Specifies the layouts that will be printed, in print order.';
                    }
                }
            }
        }
    }
    rendering
    {
        layout(CombinedInvoiceRdlc)
        {
            Type = RDLC;
            LayoutFile = './src/ReportLayout/CombinedSalesInvoice7.rdl';
            Caption = 'Combined Sales Invoice (RDLC)';
            Summary = 'Prints every selected layout for the document in one job.';
        }
    }
    var CompanyInfo: Record "Company Information";
    TempLayoutInstance: Record "Layout Instance Buffer" temporary;
    TempPrintLine: Record "Invoice Print Line Buffer" temporary;
    FormatAddr: Codeunit "Format Address";
    PrintLayoutSelectionCode: Code[20];
    SelectionDescription: Text[100];
    SelectionOrdering: Text[50];
    CompanyAddressText: Text;
    SoldToText: Text;
    ShipToText: Text;
    PhoneNoText: Text[30];
    OrderNoText: Text[35];
    PaymentTermsText: Text[100];
    CurrencySymbolText: Text[20];
    WorkDescriptionText: Text;
    FirstCopyPrinted: Boolean;
    SelectionRequiredErr: Label 'Choose an Invoice Type before printing.';
    SelectionEmptyErr: Label 'Invoice Type %1 has no layouts set up.', Comment = '%1 = selection code';
    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        // NOTE: Company Information."Picture" is a Media field in current BC, so it
        // loads without CalcFields. If your version still has it as a BLOB, add
        CompanyInfo.CalcFields(Picture);
        // here or the logo prints blank.
        CompanyAddressText:=BuildCompanyAddress();
    end;
    trigger OnPreReport()
    var
        SelLine: Record "Print Layout Selection Line";
    begin
        if PrintLayoutSelectionCode = '' then Error(SelectionRequiredErr);
        SelLine.SetRange("Selection Code", PrintLayoutSelectionCode);
        if SelLine.IsEmpty()then Error(SelectionEmptyErr, PrintLayoutSelectionCode);
    end;
    procedure SetPrintLayoutSelection(NewCode: Code[20])
    begin
        PrintLayoutSelectionCode:=NewCode;
        DescribeSelection();
    end;
    local procedure DescribeSelection()
    var
        Sel: Record "Print Layout Selection";
    begin
        Clear(SelectionDescription);
        Clear(SelectionOrdering);
        if Sel.Get(PrintLayoutSelectionCode)then begin
            SelectionDescription:=Sel.Description;
            SelectionOrdering:=Sel."Layout Ordering";
        end;
    end;
    // ----------------------------------------------------------- document texts
    local procedure BuildCompanyAddress(): Text var
        Lines: List of[Text];
    begin
        AddIfNotBlank(Lines, CompanyInfo.Address);
        AddIfNotBlank(Lines, CompanyInfo."Address 2");
        AddIfNotBlank(Lines, CompanyInfo.City);
        if CompanyInfo."Phone No." <> '' then Lines.Add('Telephone: ' + CompanyInfo."Phone No.");
        if CompanyInfo."Fax No." <> '' then Lines.Add('Fax: ' + CompanyInfo."Fax No.");
        if CompanyInfo."E-Mail" <> '' then Lines.Add('E-mail: ' + CompanyInfo."E-Mail");
        exit(JoinLines(Lines));
    end;
    local procedure BuildDocumentTexts()
    var
        PaymentTerms: Record "Payment Terms";
        SellToAddr: array[8]of Text[100];
        ShipToAddr: array[8]of Text[100];
    begin
        FormatAddr.SalesInvSellTo(SellToAddr, Header);
        FormatAddr.SalesInvShipTo(ShipToAddr, SellToAddr, Header);
        SoldToText:=JoinArray(SellToAddr);
        ShipToText:=JoinArray(ShipToAddr);
        PhoneNoText:=GetPhoneNo();
        OrderNoText:=Header."Order No.";
        Clear(PaymentTermsText);
        if PaymentTerms.Get(Header."Payment Terms Code")then PaymentTermsText:=PaymentTerms.Description;
        CurrencySymbolText:=GetCurrencySymbol(Header."Currency Code");
        WorkDescriptionText:=GetWorkDescription();
    end;
    local procedure GetPhoneNo(): Text[30]var
        ShipToAddress: Record "Ship-to Address";
        Cust: Record Customer;
    begin
        if Header."Ship-to Code" <> '' then if ShipToAddress.Get(Header."Sell-to Customer No.", Header."Ship-to Code")then if ShipToAddress."Phone No." <> '' then exit(ShipToAddress."Phone No.");
        if Cust.Get(Header."Sell-to Customer No.")then exit(Cust."Phone No.");
        exit('');
    end;
    local procedure GetCurrencySymbol(CurrencyCode: Code[10]): Text[20]var
        Currency: Record Currency;
        GLSetup: Record "General Ledger Setup";
    begin
        if CurrencyCode = '' then begin
            GLSetup.Get();
            if GLSetup."LCY Print Symbol" <> '' then exit(GLSetup."LCY Print Symbol");
            exit(GLSetup."LCY Code");
        end;
        if Currency.Get(CurrencyCode)then if Currency."Print Symbol" <> '' then exit(Currency."Print Symbol");
        exit(CurrencyCode);
    end;
    local procedure GetWorkDescription(): Text var
        TypeHelper: Codeunit "Type Helper";
        InStr: InStream;
    begin
        Header.CalcFields("Work Description");
        if not Header."Work Description".HasValue()then exit('');
        Header."Work Description".CreateInStream(InStr, TextEncoding::UTF8);
        exit(TypeHelper.ReadAsTextWithSeparator(InStr, ' '));
    end;
    // ----------------------------------------------------------- copies
    local procedure BuildLayoutInstances()
    var
        SelLine: Record "Print Layout Selection Line";
        SeqNo: Integer;
    begin
        TempLayoutInstance.Reset();
        TempLayoutInstance.DeleteAll();
        Header.CalcFields(Amount);
        SelLine.SetCurrentKey("Selection Code", "Line No.");
        SelLine.SetRange("Selection Code", PrintLayoutSelectionCode);
        if SelLine.FindSet()then repeat SeqNo+=1;
                TempLayoutInstance.Init();
                TempLayoutInstance."Sequence No.":=SeqNo;
                TempLayoutInstance."Layout No.":=SelLine."Layout No.";
                TempLayoutInstance."Total Amount":=Header.Amount;
                TempLayoutInstance."Suppress Page Break":=not FirstCopyPrinted;
                FirstCopyPrinted:=true;
                SetLayoutFlags(TempLayoutInstance);
                TempLayoutInstance.Insert();
            until SelLine.Next() = 0;
    end;
    local procedure SetLayoutFlags(var Buf: Record "Layout Instance Buffer" temporary)
    begin
        // Defaults shared by layouts 1-5 (the INVOICE family).
        Buf."Document Title":='INVOICE';
        Buf."Sold-To Label":='SOLD TO :';
        Buf."Show Pricing":=true;
        Buf."Show Total Box":=true;
        Buf."Show Total Value":=true;
        case Buf."Layout No." of 1: // Cargo Receipt
 begin
            Buf."Stamp Caption":='CARGO RECEIPT';
            Buf."Stamp Number":='(1)';
        end;
        2: // Pharmaceutical Product - no prices, TOTAL box printed but empty
 begin
            Buf."Stamp Caption":='Pharmaceutical Product';
            Buf."Stamp Number":='(2)';
            Buf."Show Pricing":=false;
            Buf."Show Total Value":=false;
        end;
        3: // Poison - no prices, boxed stamp, doctor/pharmacist signature block
 begin
            Buf."Stamp Caption":='POISON';
            Buf."Stamp Number":='(3)';
            Buf."Show Pricing":=false;
            Buf."Show Signature Block":=true;
            Buf."Stamp Boxed":=true;
        end;
        4: // Original
 begin
            Buf."Stamp Caption":='ORIGINAL';
            Buf."Stamp Number":='(4)';
        end;
        5: // Warehouse - number only, otherwise identical to Original
 begin
            Buf."Stamp Caption":='';
            Buf."Stamp Number":='(5)';
        end;
        6: // Order Form - different document altogether
 begin
            Buf."Document Title":='ORDER FORM';
            Buf."Sold-To Label":='Order by :';
            Buf."Stamp Caption":='Order Form';
            Buf."Stamp Number":='';
            Buf."Show Pricing":=false;
            Buf."Show Order Form Style":=true;
            Buf."Show Total Box":=false;
            Buf."Show Total Value":=false;
        end;
        end;
    end;
    // ----------------------------------------------------------- printed lines
    local procedure BuildPrintLines(LayoutNo: Integer)
    var
        InvLine: Record "Sales Invoice Line";
        RowNo: Integer;
        DisplayLineNo: Integer;
        DescriptionText: Text;
    begin
        TempPrintLine.Reset();
        TempPrintLine.DeleteAll();
        InvLine.SetRange("Document No.", Header."No.");
        InvLine.SetFilter(Type, '<>%1', InvLine.Type::" ");
        if not InvLine.FindSet()then exit;
        repeat DisplayLineNo+=1;
            RowNo+=1;
            DescriptionText:=InvLine.Description;
            if InvLine."Description 2" <> '' then DescriptionText+=' ' + InvLine."Description 2";
            TempPrintLine.Init();
            TempPrintLine."Row No.":=RowNo;
            TempPrintLine."Row Type":=1;
            TempPrintLine."Line No. Text":=Format(DisplayLineNo);
            TempPrintLine."Product Code":=CopyStr(InvLine."No.", 1, MaxStrLen(TempPrintLine."Product Code"));
            if(LayoutNo <> 6) and (InvLine."Location Code" <> '')then TempPrintLine."Product Code 2":=CopyStr(StrSubstNo('( %1 )', InvLine."Location Code"), 1, MaxStrLen(TempPrintLine."Product Code 2"));
            TempPrintLine.Description:=CopyStr(DescriptionText, 1, MaxStrLen(TempPrintLine.Description));
            TempPrintLine."Unit Price":=InvLine."Unit Price";
            if LayoutNo <> 6 then TempPrintLine."UOM Text":=CopyStr(InvLine."Unit of Measure Code", 1, MaxStrLen(TempPrintLine."UOM Text"));
            TempPrintLine.Quantity:=InvLine.Quantity;
            TempPrintLine.Amount:=InvLine.Amount;
            TempPrintLine.Insert();
            if LayoutNo <> 6 then AddTrackingRows(RowNo, InvLine);
        until InvLine.Next() = 0;
    end;
    local procedure AddTrackingRows(var RowNo: Integer; InvLine: Record "Sales Invoice Line")
    var
        ValueEntry: Record "Value Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
        TempItemLedgEntry: Record "Item Ledger Entry" temporary;
        LotKeys: List of[Text];
        LotQty: Dictionary of[Text, Decimal];
        LotExpiry: Dictionary of[Text, Date];
        LotSN: Text;
        i: Integer;
    begin
        if InvLine.Type <> InvLine.Type::Item then exit;
        ValueEntry.SetRange("Document No.", InvLine."Document No.");
        ValueEntry.SetRange("Document Line No.", InvLine."Line No.");
        ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Sale);
        if ValueEntry.FindSet()then repeat if not TempItemLedgEntry.Get(ValueEntry."Item Ledger Entry No.")then if ItemLedgEntry.Get(ValueEntry."Item Ledger Entry No.")then begin
                        TempItemLedgEntry:=ItemLedgEntry;
                        TempItemLedgEntry.Insert();
                    end;
            until ValueEntry.Next() = 0;
        if TempItemLedgEntry.FindSet()then repeat LotSN:=TempItemLedgEntry."Lot No.";
                if LotSN = '' then LotSN:=TempItemLedgEntry."Serial No.";
                if LotSN <> '' then begin
                    if not LotQty.ContainsKey(LotSN)then begin
                        LotKeys.Add(LotSN);
                        LotQty.Add(LotSN, 0);
                        LotExpiry.Add(LotSN, TempItemLedgEntry."Expiration Date");
                    end;
                    // Sales entries are stored with a negative quantity.
                    LotQty.Set(LotSN, LotQty.Get(LotSN) - TempItemLedgEntry.Quantity);
                end;
            until TempItemLedgEntry.Next() = 0;
        for i:=1 to LotKeys.Count()do begin
            LotSN:=LotKeys.Get(i);
            RowNo+=1;
            TempPrintLine.Init();
            TempPrintLine."Row No.":=RowNo;
            TempPrintLine."Row Type":=2;
            TempPrintLine.Description:=CopyStr(BuildTrackingText(LotSN, LotExpiry.Get(LotSN), LotQty.Get(LotSN)), 1, MaxStrLen(TempPrintLine.Description));
            TempPrintLine.Insert();
        end;
    end;
    local procedure BuildTrackingText(LotSN: Text; ExpirationDate: Date; Qty: Decimal): Text var
        Result: Text;
    begin
        Result:='Lot / SN : ' + LotSN;
        if ExpirationDate <> 0D then Result+='   Exp : ' + Format(ExpirationDate, 0, '<Day> <Month Text,3> <Year4>');
        Result+='   X ' + Format(Qty, 0, '<Precision,0:2><Standard Format,0>');
        exit(Result);
    end;
    // ----------------------------------------------------------- helpers
    local procedure AddIfNotBlank(var Lines: List of[Text]; Value: Text)
    begin
        if Value <> '' then Lines.Add(Value);
    end;
    local procedure JoinLines(Lines: List of[Text]): Text var
        Builder: TextBuilder;
        i: Integer;
    begin
        for i:=1 to Lines.Count()do begin
            if i > 1 then Builder.AppendLine();
            Builder.Append(Lines.Get(i));
        end;
        exit(Builder.ToText());
    end;
    local procedure JoinArray(AddrArray: array[8]of Text[100]): Text var
        Lines: List of[Text];
        i: Integer;
    begin
        for i:=1 to ArrayLen(AddrArray)do AddIfNotBlank(Lines, AddrArray[i]);
        exit(JoinLines(Lines));
    end;
}

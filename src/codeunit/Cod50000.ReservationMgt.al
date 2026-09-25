codeunit 50000 "Reservation Mgt."
{
    var Var VarCustomField1: text[30];
    ModifyRun: Boolean;
    //Update custom field values For New Insert value Updated in Reservation Entry
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterChangeOnChangeTypeInsertOnBeforeInsertReservEntry', '', false, false)]
    local procedure OnRegisterChangeOnChangeTypeInsertOnBeforeInsertReservEntry(var OldTrackingSpecification: Record "Tracking Specification"; var NewTrackingSpecification: Record "Tracking Specification")
    Begin
        ModifyRun:=false;
        VarCustomField1:=NewTrackingSpecification."Packing Size";
    End;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", 'OnAfterSetDates', '', false, false)]
    local procedure OnAfterSetDates(var ReservationEntry: Record "Reservation Entry")
    Begin
        ReservationEntry."Packing Size":=VarCustomField1;
    End;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", 'OnCreateReservEntryExtraFields', '', false, false)]
    local procedure OnCreateReservEntryExtraFields(var InsertReservEntry: Record "Reservation Entry"; OldTrackingSpecification: Record "Tracking Specification"; NewTrackingSpecification: Record "Tracking Specification")
    Begin
        InsertReservEntry."Packing Size":=NewTrackingSpecification."Packing Size";
    End;
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterCopyTrackingSpec', '', false, false)]
    local procedure OnAfterCopyTrackingSpec(var SourceTrackingSpec: Record "Tracking Specification"; var DestTrkgSpec: Record "Tracking Specification")
    Begin
        If ModifyRun = false then begin
            SourceTrackingSpec."Packing Size":=DestTrkgSpec."Packing Size";
        end
        else
        begin
            //For Modified value flow
            DestTrkgSpec."Packing Size":=SourceTrackingSpec."Packing Size";
        end;
    End;
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterItemTrackingLinesOnBeforeInsert', '', false, false)]
    local procedure OnRegisterItemTrackingLinesOnBeforeInsert(var TrackingSpecification: Record "Tracking Specification"; var TempTrackingSpecification: Record "Tracking Specification" temporary; SourceTrackingSpecification: Record "Tracking Specification")
    Begin
        TrackingSpecification."Packing Size":=TempTrackingSpecification."Packing Size";
    End;
    //Update modified custom field values For New Insert value Updated in Reservation Entry
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterEntriesAreIdentical', '', false, false)]
    local procedure OnAfterEntriesAreIdentical(ReservEntry1: Record "Reservation Entry"; ReservEntry2: Record "Reservation Entry"; var IdenticalArray: array[2]of Boolean)
    Begin
        IdenticalArray[2]:=(ReservEntry1."Packing Size" = ReservEntry2."Packing Size")End;
    // [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterChangeOnBeforeAddItemTrackingToTempRecSet', '', false, false)]
    // local procedure OnRegisterChangeOnBeforeAddItemTrackingToTempRecSet(var OldTrackingSpecification: Record "Tracking Specification"; var NewTrackingSpecification: Record "Tracking Specification")
    // Begin
    //     OldTrackingSpecification."Custom Field 1" := NewTrackingSpecification."Custom Field 1";
    //     OldTrackingSpecification."Custom Field 2" := NewTrackingSpecification."Custom Field 2";
    // End;
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterMoveFields', '', false, false)]
    local procedure OnAfterMoveFields(var TrkgSpec: Record "Tracking Specification"; var ReservEntry: Record "Reservation Entry")
    Begin
        ReservEntry."Packing Size":=TrkgSpec."Packing Size";
    End;
    //Custom Values flow to ILE
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertSetupTempSplitItemJnlLine', '', false, false)]
    local procedure OnBeforeInsertSetupTempSplitItemJnlLine(var TempItemJournalLine: Record "Item Journal Line" temporary; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    Begin
        TempItemJournalLine."Packing Size":=TempTrackingSpecification."Packing Size";
    End;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line")
    Begin
        NewItemLedgEntry."Packing Size":=ItemJournalLine."Packing Size";
    End;
    //Assign Custom Values to Sales Shipments
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterValidateEvent', 'Lot No.', false, false)]
    local procedure TrackingSpecificatioOnAfterValidateEventLotNo(var Rec: Record "Tracking Specification")
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemLedgerEntry2: Record "Item Ledger Entry";
    Begin
        ItemLedgerEntry2.Reset();
        ItemLedgerEntry2.SetRange("Lot No.", Rec."Lot No.");
        If ItemLedgerEntry2.FindFirst()then begin
            Rec."Packing Size":=ItemLedgerEntry2."Packing Size";
        end;
    End;
}

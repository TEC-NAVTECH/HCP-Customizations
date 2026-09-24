# Packing Size Item Tracking Extension

Adds a `Packing Size` field to item tracking and carries it through
posting onto the Item Ledger Entry.

## Structure

```
app.json
src/
  TableExtensions/
    TrackingSpecification.TableExt.al   (336 - entry buffer / UI)
    ReservationEntry.TableExt.al        (337 - persisted document tracking)
    ItemJournalLine.TableExt.al         (83  - carrier into posting)
    ItemLedgerEntry.TableExt.al         (32  - final target)
  PageExtensions/
    ItemTrackingLines.PageExt.al        (6510 - where users type the value)
  Codeunits/
    PackingSizeEvents.Codeunit.al       (all event subscribers)
```

## Why one field ID (50100) everywhere

Tracking Specification (336) and Reservation Entry (337) are designed
as structural twins in the base application, and Item Ledger Entry /
Item Journal Line generic field-copy logic sometimes relies on matching
field IDs. Using the same ID and name across all four tables lets the
value ride along automatically in more places, and keeps any custom
copy code trivial.

## What's confirmed vs. what needs testing in your environment

- **Item Journal Line → Item Ledger Entry**: solid, uses the documented
  `OnAfterInitItemLedgEntry` event on codeunit 22 "Item Jnl.-Post Line".
- **Reservation Entry → Item Journal Line**: covered defensively via a
  table event on Item Journal Line, but the exact mechanics of how
  codeunit 22 splits journal lines per tracking number are internal, so
  test this against your actual posting flow.
- **Document line → Item Journal Line**: only needed if Packing Size is
  typed directly on a sales/purchase/transfer line rather than picked
  from existing tracked stock. Left as a commented example in the
  codeunit — tell me which document type(s) you post from and I'll fill
  in the confirmed event for that specific posting codeunit.

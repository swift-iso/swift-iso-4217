# swift-iso-4217

Use this package when you need to validate, store or look up ISO 4217 currency codes. Start from `ISO_4217.Code`.

## Laws

- A code is exactly three ASCII letters. Anything else is refused.
- Codes are case-insensitive on input and always stored uppercase, so `eur` and `EUR` give equal values and both print and encode as `EUR`.
- A well-formed code that isn't in the current table is still a code: withdrawn currencies such as `NLG` stay readable in old records. Its `entry` is nil.
- `entry` holds what ISO 4217's list one publishes for a code in the table: its three-digit number, its minor units and its name. Minor units are nil where the list says "N.A.", as for gold.
- A code encodes as a single string, its stored form, and decoding validates the string the same way the initializer does.

The table is generated from list one as published by SIX, the ISO 4217 maintenance agency, dated 2026-09-17.

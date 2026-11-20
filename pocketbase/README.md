# PocketBase schema

`schema-import.json` is the canonical PocketBase collection baseline for MMEX
schema version 21. Its 25 business collections have the names and fields in
`../tables.sql`; `dbInfo` stores the MMEX schema version. PocketBase record IDs
are separate from the MMEX integer business keys. Matching field names does not
imply identical constraints, indexes, data semantics or synchronization.

`defaults.json` contains the category and currency seed data used by the
WebApp. These files are bundled into the WebApp for remote initialization; in
the WebApp checkout run `sh scripts/sync-pocketbase-schema.sh` after changes,
and commit both repositories' changes together. Use `--check` to detect drift.
Run `node --test tests/pocketbase-schema.test.js` from the database root to
compare business collection names, fields and types with `tables.sql`
(requires Node.js and the SQLite CLI).

Existing PocketBase v1 instances may be marked v21 by WebApp administrator setup
after a collection and field-type check. This is a schema-baseline transition,
not execution of SQLite's v20/v21 data repairs. Back up and stop other clients
before the transition; older WebApp versions reject v21.

For each future MMEX schema version, review the corresponding SQLite changes
and provide a PocketBase-specific, ordered migration wherever needed. Preserve
record IDs and business data, validate preconditions and results, handle
partial failures, and advance the version only after success. Test upgrades
from all supported baselines on restored backups. Do not import a new snapshot
over an existing dataset as a substitute for migration.

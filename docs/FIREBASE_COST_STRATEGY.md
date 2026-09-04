# FIREBASE_COST_STRATEGY.md

> Goal: keep the app comfortably within the **Spark (free) plan** and avoid needing a billing account. All figures are the free-tier quotas cited in `FIREBASE_AND_SECURITY.md §11` (re-verify on the Firebase pricing page before production).

## Free-tier budget (Spark)
- Firestore: ~1 GiB storage, ~50K reads/day, ~20K writes/day, ~20K deletes/day.
- Auth email/password: ≤50K MAUs, no cost.
- App Check: no cost. Play Integrity: ~10,000 requests/day default.

## Expected read patterns
- Main list: **one** user-scoped query `users/{uid}/entries` with `limit` + pagination (e.g. 20–50 per page, `orderBy(createdAt, desc)`). Avoid reading all periods eagerly.
- Detail/edit: read the single entry already in memory; avoid a re-fetch.
- Rely on Firestore **cache** for repeat views (served from cache does not count as a network read the same way; still design for minimal reads).

## Expected write patterns
- Create/update entry: **one** write on explicit Save — never on keystroke. Total is computed locally and written once.
- No denormalized aggregate rewrites on every entry unless a real feature needs them.

## Listener scopes
- At most **one** realtime listener: the user's entries list, scoped by `uid` and bounded by `limit`. Cancel it on screen dispose.
- Prefer one-shot `get()` for data that does not need to be live (e.g. a single entry opened for editing). See `DECISIONS.md` ADR-003.
- Never open a listener inside `build`/on every rebuild; create it once in the state and manage its `StreamSubscription`.

## Cache behavior
- Firestore native offline persistence ON (default on mobile) → cached reads offline, queued writes, auto-sync.
- Use snapshot metadata (`isFromCache`, `hasPendingWrites`) where a "syncing" indicator helps UX.

## Query limits & indexes
- Always `limit(...)`. Paginate with `startAfter(...)`.
- Create composite indexes only as specific queries require (Console links the exact index on a failed query, or define in `firestore.indexes.json`).

## Potential cost risks
- Unbounded collection listeners; listeners duplicated on rebuild; per-keystroke writes; full-collection fetch filtered client-side; large documents rewritten frequently; polling instead of a scoped listener; global listeners kept alive without need.

## Mitigations
- User-scoped + `limit`ed queries, pagination, one lifecycle-managed listener, explicit Save, cache reuse, no keystroke writes.

## Metrics to monitor in Firebase Console
- Firestore **Usage** tab: reads/writes/deletes/day vs free quota.
- App Check **metrics**: verified vs unverified requests (before enabling enforcement).
- Auth: MAU count.
- Set **budget/usage alerts** (even on Spark, to catch runaway usage before hitting caps).

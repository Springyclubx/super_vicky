# DECISIONS.md — Architecture Decision Records

Lightweight ADRs. Status: `Proposed` until the user confirms. None are implemented yet.

---
## ADR-001: Firebase-only vs Spring Boot backend
- **Status:** Proposed (recommend Firebase-only now)
- **Context:** No backend exists. Developer has little backend experience but is interested in Spring Boot. Current features (auth, per-user product entries, totals) are all client + Firestore + Rules.
- **Options:** (A) Firebase-only. (B) Add a Spring Boot backend now. (C) Local Spring Boot on the developer's PC, synced opportunistically.
- **Decision:** **(A) Firebase-only now.** No operation currently requires trusted server-side code (no admin user management, privileged cross-user writes, secret third-party calls, scheduled jobs, or tamper-resistant global aggregation).
- **Reasoning:** Firestore Security Rules + App Check cover the current trust needs on the free plan with no billing. A backend now adds hosting, TLS, auth bridging, and reachability complexity for no present benefit. Option C (PC-hosted server) has severe issues: dynamic IPs, mobile reachability, availability, TLS, data-loss/retry/duplication, backups — unsuitable as production architecture.
- **Consequences:** Faster delivery; design repository boundaries so a backend can be introduced later without rewriting UI. Do not scatter speculative backend interfaces everywhere.
- **Revisit when:** a feature needs admin user management, privileged/cross-user operations, secret keys, scheduled jobs, webhooks, or tamper-resistant aggregation. Then consider Cloud Functions first, Spring Boot second. Suggested learning path: start with Cloud Functions (JS/TS) for server logic; adopt Spring Boot later as a learning project behind the repository interface.

---
## ADR-002: Firestore offline persistence vs a separate local database
- **Status:** Proposed (recommend Firestore native persistence)
- **Context:** App should tolerate unstable/absent internet. Options weigh a second DB (Drift/Isar/Hive/SQLite).
- **Options:** (A) Firestore native offline persistence. (B) Add a dedicated local database.
- **Decision:** **(A)** for business data; `shared_preferences` for simple prefs (theme/language).
- **Reasoning:** Firestore already gives cached reads, offline writes, and auto-sync on mobile — sufficient for the current single-operator CRUD. A second DB introduces two sources of truth and a sync engine with no current justification.
- **Consequences:** No custom sync code now. If future needs arise (offline-first drafts, explicit sync status, large local queries, advanced conflict resolution), revisit and, if adopted, document source of truth, sync direction, conflict resolution, retries, duplicate prevention, local vs remote IDs, deletion sync, migrations, encryption, recovery.
- **Revisit when:** any of those future needs become real.

---
## ADR-003: Realtime listeners vs manual refresh/query
- **Status:** Proposed
- **Context:** Cost control matters (stay on free plan). Data is per-user product entries.
- **Options:** (A) Realtime `snapshots()` listener for the list. (B) One-shot `get()` with manual/pull-to-refresh.
- **Decision:** **One scoped, lifecycle-managed realtime listener for the entries list** (bounded by `uid` + `limit` + pagination); **one-shot `get()`** for single-entry edit views.
- **Reasoning:** A single bounded listener gives good UX (live updates for a single operator) at negligible cost; unbounded/duplicated listeners are the real cost risk. Editing a known entry does not need a live stream.
- **Consequences:** Must manage `StreamSubscription` lifecycle (create once, cancel on dispose); never create listeners in `build`.
- **Revisit when:** multiple concurrent writers or larger datasets change the cost/UX tradeoff.

---
## ADR-004: App Check provider for Android
- **Status:** Proposed
- **Context:** Android-only; developer worried about billing from reCAPTCHA.
- **Options:** (A) Play Integrity (Android). (B) reCAPTCHA (web provider).
- **Decision:** **(A) Play Integrity** for release; **debug provider** for dev/CI. reCAPTCHA is web-only and not used.
- **Reasoning:** Play Integrity is the official Android provider, free default quota, no billing. Enforcement staged only after valid tokens are confirmed. (See `FIREBASE_AND_SECURITY.md §3/§11`.)
- **Consequences:** Add `firebase_app_check`; register app + SHA-256 in Console; register debug tokens; keep enforcement OFF until verified.
- **Revisit when:** web support is added (reCAPTCHA enters the picture).

---
## ADR-005: User creation & authentication flow
- **Status:** Proposed
- **Context:** Code implements email/password sign-in only; no signup/reset/verification.
- **Options:** (A) Manual user creation in Console, email/password sign-in only. (B) In-app public registration.
- **Decision:** **(A)** — no public registration screen; users provisioned in Console; email/password sign-in; auth-state stream drives gating; logout clears session.
- **Reasoning:** Matches existing code and the stated direction; minimizes attack surface and avoids abuse/anti-bot needs that could pull in reCAPTCHA/billing.
- **Consequences:** Onboarding is manual. Consider adding password reset later (needs Console email template) if operators self-manage credentials.
- **Revisit when:** the product needs self-service onboarding or multiple roles.

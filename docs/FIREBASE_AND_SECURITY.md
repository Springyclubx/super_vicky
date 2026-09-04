# FIREBASE_AND_SECURITY.md

> No secrets in this file. API keys, app IDs, and `google-services.json` contents are intentionally omitted. Values below are limited to non-sensitive project **names** already present in tracked config, described only enough to flag mismatches.

## 1. Firebase configuration discovered (and a critical mismatch)

> **RESOLVED 2026-07-30.** Canonical config is now Firebase project **`super-vicky-222ec`**, Android `applicationId` **`super.vicky`**, code namespace **`com.supervicky`**. `flutterfire configure` regenerated `firebase_options.dart`, `.firebaserc`, `firebase.json`, and wrote `android/app/google-services.json` (appId `…android:e6f7847d44522291b8c328`) + the google-services Gradle plugin. Debug APK builds successfully. The historical mismatch below is kept for the record.

The repository originally pointed at **multiple different Firebase projects**, which had to be reconciled before Firebase could work:

| Source | Location | Firebase project | Notes |
|---|---|---|---|
| `.firebaserc`, `firebase.json` (untracked, working tree) | repo root | `super-vicky-740f6` | Android + dart configs, emulator (auth :9099) |
| stashed `firebase_options.dart` (in `git stash`) | `lib/` | `super-vicky-740f6` | matches `.firebaserc` |
| stashed `google-services.json` (in `git stash`) | `android/app/` | **`super-vicky-1d0c3`** | **different project**, and package `com.syper_vicky` (a typo of `super`) |
| committed `firebase_options.dart` | `lib/firebase_options.dart` | placeholder (`seu-projeto-id`) | **fake values** — used by `main.dart` today |
| `android/app/build.gradle.kts` | Android | `applicationId = com.example.super_vicky` | third identifier |

**Consequences**
- As committed, `main.dart` initializes Firebase with placeholder options → initialization fails.
- The `google-services.json` provided (stashed) is for a *different* project and a *misspelled* package name (`com.syper_vicky`) that matches neither the Android `applicationId` (`com.example.super_vicky`) nor the FlutterFire config project (`super-vicky-740f6`).
- The Android Gradle Google-services plugin is **not applied** in the committed `build.gradle.kts` (only in the stash).

**Required decision (blocking, user action):** pick ONE Firebase project and ONE Android package name, then regenerate config via `flutterfire configure` so `google-services.json`, `firebase_options.dart`, `.firebaserc`, and the Android `applicationId` all agree. Do not hand-edit keys. See the Console checklist below. This is recorded as an OPEN item; do not guess which project is canonical.

## 2. Authentication strategy
- Provider: **email/password only**. No phone auth (avoids per-SMS billing). No public registration screen — users are created manually in the Console (`INFERRED`, matches intended direction).
- Observe `authStateChanges()`; gate protected UI on a non-null user; logout clears session. Map `FirebaseAuthException` to user-safe messages (do not surface raw text).

## 3. App Check strategy (Android)
Based on current official Firebase docs (researched 2026-07-29):
- **Android production provider: Play Integrity** (the built-in Android provider). reCAPTCHA providers are the **web** attestation path — not used on Android.
- **Development/CI: debug provider.** Register the logged debug token in Console → Security → App Check → Apps → ⋮ → *Manage debug tokens*. Keep debug tokens private; never commit them or ship them in release.
- **Enforcement staging:** App Check enforcement is per-product and OFF by default. **Do not enable enforcement** (for Firestore/Auth) until real devices (Play Integrity) and registered debug tokens are confirmed to obtain valid tokens. Watch the App Check metrics dashboard first.
- **Billing:** App Check is no-cost; Play Integrity has a free default quota (~10,000 requests/day, tied to the Cloud project number) and requires **no billing account**. Token TTL default 1h (30 min–7 days); shorter TTLs consume quota faster.
- Not yet implemented in code — add `firebase_app_check` when this phase starts.

## 4. Firestore structure (target — none exists yet)
Proposed (confirm with product owner; see `BUSINESS_RULES.md` open questions):
```
users/{uid}/entries/{entryId}
  ownerUid: string  (== request.auth.uid)
  model: string
  code: string
  quantity: int    (> 0)
  valueMinor: int  (unit price in cents, >= 0)   // precise money
  totalMinor: int  (== quantity * valueMinor)     // server-recalculated/validated
  createdAt: timestamp (server)
  updatedAt: timestamp (server)
```
Document IDs: auto-generated (not email, not code). Ownership: per `uid`. Timestamps: **server** timestamps for ordering. Do not duplicate user profile data across entries.

## 5. Security Rules strategy
- **Deny-by-default.** Never `allow read, write: if true;`.
- Rules validate: authenticated (`request.auth != null`), ownership (`resource.data.ownerUid == request.auth.uid` / `request.resource.data.ownerUid == request.auth.uid` on create), required fields present, field **types** (`is int`, `is string`, `is timestamp`), numeric **ranges** (`quantity > 0`, `valueMinor >= 0`), **immutable** fields on update (`ownerUid`, `createdAt` unchanged), and per-op authorization (create/read/update/delete).
- Client-side validation is UX only; Rules are the security boundary.
- Every new collection/doc type gets a rule design **before** its app code is considered complete.
- Test rules with the **Firebase Emulator Suite** (`firebase.json` already configures the auth emulator on :9099; add firestore emulator).

## 6. Local caching & offline behavior
Prefer **Firestore native offline persistence** (enabled by default on mobile) — cached reads, queued offline writes, auto-sync. Do not add a second local database without a documented sync strategy (see `DECISIONS.md`). Preferences (theme/language) use `shared_preferences`.

## 7. Query & listener strategy
User-scoped queries only; add `limit`, pagination, and required composite indexes; one listener per data scope with explicit lifecycle (cancel on dispose). No writes on keystroke; no full-collection fetches filtered client-side. Details in `FIREBASE_COST_STRATEGY.md`.

## 8. Cost-control strategy
Summary: everything in the intended stack fits the **free Spark plan** (see §11). Guard rails and metrics to watch are in `FIREBASE_COST_STRATEGY.md`.

## 9. Manual Firebase Console actions
**Required now (development)**
1. Decide the canonical Firebase project + Android package; run `flutterfire configure` to regenerate all config consistently.
2. Build → Authentication → Get started → Sign-in method → enable **Email/Password**. Do **not** enable Phone.
3. Create test user(s) under Authentication → Users (no public signup).
4. Build → Firestore Database → create database; choose a region close to users (region is permanent).
5. Publish initial deny-by-default Security Rules.

**Required before production**
6. Security → App Check → Apps → register Android app with **Play Integrity**.
7. Project settings → Your apps → Android → add **SHA-256** fingerprint(s) (upload + Play app-signing cert for Play-signed apps; debug keystore SHA-256 for local). Needed so Play Integrity attestation can verify your signed app.
8. Create Firestore composite indexes as queries require (Console will link the exact index from a failed query, or define in `firestore.indexes.json`).
9. Configure password-reset email template *if* password reset is added.
10. Stage App Check **enforcement** per product only after valid tokens are confirmed. Set budget/usage alerts.

**Optional / Web only / Verify**
- Storage: only if the app actually stores files (new projects gate the default bucket behind Blaze — avoid unless needed).
- Authorized domains + reCAPTCHA provider: **web only**, if web is added later.
- Re-verify pricing and App Check provider naming before production — Firebase policies have changed historically.

## 10. Development vs production setup
- **Dev:** App Check debug provider + registered debug token; Firebase Emulator Suite (auth :9099, add firestore); enforcement OFF.
- **Prod:** App Check Play Integrity; SHA-256 registered; enforcement ON per product after token validation; release signing config (currently release uses the **debug** signing key — must be replaced before shipping).

## 11. Billing / reCAPTCHA / App Check conclusion (grounded in official docs, 2026-07-29)
- **What triggers the "add a credit card" prompt:** phone/SMS auth (pay-per-use), reCAPTCHA **Enterprise** full functionality (a **web** App Check provider), Cloud Functions/Storage/outbound networking — **none of which this app uses**.
- **Is billing actually required?** No. For Android-only, email/password + Firestore + App Check via Play Integrity, the app runs on **Spark with no billing account**. Firebase pricing explicitly states Spark needs "no payment method."
- **Works on free plan:** Email/Password auth (≤50K MAUs), Firestore within free quota (~1 GiB storage, ~20K writes/day, ~50K reads/day), App Check (no-cost), Play Integrity (free default quota).
- **What stops without billing:** only the unused features above; if Firestore free quota is exceeded, requests are throttled until the next day (no overage billing on Spark) — serving more needs Blaze.
- **Recommended Android App Check:** Play Integrity (prod) + debug provider (dev); no billing needed.
- **Web differences:** web App Check uses reCAPTCHA (v3/Enterprise), reintroducing possible billing considerations — out of current scope.

## 12. Risks & mitigations
| Risk | Mitigation |
|---|---|
| Two projects / misspelled package | Reconcile to one project + package via `flutterfire configure` before any Firebase work (blocking). |
| Placeholder `firebase_options.dart` in use | Regenerate; verify `Firebase.initializeApp` succeeds. |
| Release build signed with debug key | Add real release signing before production. |
| Cleartext traffic enabled (stashed `network_security_config.xml`, `cleartextTrafficPermitted="true"`) | Remove/restrict before production; not needed for Firebase over HTTPS. |
| Enforcing App Check too early | Stage enforcement; verify tokens first. |
| Firestore quota overrun | Scoped queries, limits, caching, usage alerts (`FIREBASE_COST_STRATEGY.md`). |

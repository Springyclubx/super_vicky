# IMPLEMENTATION_PLAN.md

> Phased plan. Each task lists Objective, Files affected, Risks, Tests, Manual Firebase actions, and Completion status. No application code has been changed yet (Phases 0–2 are audit + docs). Do not begin a later phase before the user approves.

Legend: ☐ not started · ◐ in progress · ☑ done

## Phase 0 — Safety inspection ☑
- **Objective:** Understand the project without editing app code.
- **Done:** git status/stash reviewed; structure, pubspec, Firebase setup, Android gradle, architecture, form widgets, state, models, tests, and warnings inspected.
- **Findings:** see `PROJECT_OVERVIEW.md` (debt list) and `FIREBASE_AND_SECURITY.md §1`.

## Phase 1 — Agents & audit reports ☑
- **Objective:** Create project subagents; run read-only audit; consolidate.
- **Done:** `.claude/agents/` created (project-auditor, business-rules-analyst, architecture-guardian, firebase-security-auditor, mobile-ui-reviewer, test-and-quality-reviewer). Firebase billing/App Check researched against official docs.

## Phase 2 — Documentation ☑
- **Objective:** Author governing docs. **Done:** `CLAUDE.md`, `PROJECT_OVERVIEW.md`, `BUSINESS_RULES.md`, `ARCHITECTURE.md`, `FIREBASE_AND_SECURITY.md`, `FIREBASE_COST_STRATEGY.md`, `DECISIONS.md`, this file.

---
## Phase 3 — Minimal stabilization ◐ (mostly done 2026-07-30)
- **Objective:** Make the app build, analyze, and initialize Firebase correctly without changing behavior or redesigning UI.
- **Canonical config confirmed by user:** Firebase project `super-vicky-222ec`; Android `applicationId = super.vicky`; Kotlin `namespace`/package `com.supervicky` (because `super` is a reserved Kotlin keyword and cannot be a package segment).
- **Tasks:**
  1. ☑ **`pubspec.yaml`** fixed (valid `dependencies` / `dev_dependencies` / `flutter:` + `fonts:`). All 10 Inter fonts exist.
  2. ☑ **Reconcile Firebase config** — ran `flutterfire configure --project=super-vicky-222ec --platforms=android --android-package-name=super.vicky` (user-authorized). Regenerated `lib/firebase_options.dart`, wrote `android/app/google-services.json` (project 222ec, package super.vicky, appId `…android:e6f7847d44522291b8c328`), applied the google-services Gradle plugin (`app/build.gradle.kts` + `settings.gradle.kts`).
  3. ☑ **Firebase init** — `main.dart` now uses `DefaultFirebaseOptions.currentPlatform` (single init).
  4. ☑ **Android package rename** — `applicationId = super.vicky`, `namespace = com.supervicky`, `MainActivity.kt` moved to `.../kotlin/com/supervicky/`.
  5. ☑ **Removed nested `MaterialApp`** in `main_screen.dart` (outer `HomePage` MaterialApp now provides theme/l10n/routes).
  6. ☐ **Dispose controllers** in `ChangeNotifier`s — still pending.
  7. ☐ Reconcile `home:` vs `initialRoute` in `HomePage` (minor; `home` currently wins) — pending.
- **Verification:** `flutter pub get` ✓, `dart format .` ✓, `flutter analyze` → No issues found ✓, `flutter build apk --debug` → built ✓. No `_test.dart` files yet.
- **Remaining risk:** release build still signed with the debug key; App Check not yet added; Firestore not yet created (project resource location unset).

## Phase 4 — Business functionality ☐
- **Objective:** Real auth gating; form rules; pre-populated date/time; model/code behavior; quantity/value validation; automatic total; **persistence to Firestore**; error handling.
- **Tasks:** add `domain/repositories` + `data/` layer (`EntryRepository`/`Impl`, `EntryDataSource`, `EntryMapper`); switch money to integer minor units; add `Validator`s; wire form Save (one write); replace mock `ProductListState` with a scoped query; fix `HH:dd`→`HH:mm`, `dd/MM/yyy`→`dd/MM/yyyy`.
- **Files:** new `data/`/`domain/repositories/`, `form_data_state.dart`, `product_list_state.dart`, `product_model.dart`, `close_products_model.dart`, formatters.
- **Risks:** money representation change touches calc + display; keep behavior tested.
- **Tests:** money parse/calc/rounding (decimals, zero, invalid, large, locale), validation, date/time pre-pop, mapping/serialization, submission + duplicate-submit prevention.
- **Manual Firebase:** enable Email/Password; create test users; create Firestore; publish rules.

## Phase 5 — Offline & Firebase efficiency ☐
- **Objective:** Implement approved strategy (ADR-002/003): Firestore offline persistence, one scoped list listener, one-shot get for edits, limits/pagination/indexes, listener lifecycle.
- **Tests:** listener created once; cancelled on dispose; paginated query; offline cache read.

## Phase 6 — Theme & localization ☐
- **Objective:** Light/Dark/System switch + `Color(0xFFFA8072)` token usage; pt/en language switch; persist both via `shared_preferences`; populate `.arb`; remove hardcoded strings.
- **Tests:** theme persistence; language persistence; fallback when a key is missing.

## Phase 7 — UI improvement ☐
- **Objective:** Mobile-first redesign preserving rules; responsive (avoid dense two-column rows on narrow screens); empty/loading/error/success states; accessible touch targets; inline validation.
- **Rule:** every extracted visual becomes a `...Widget` class; convert `appBarDefault` to a class.

## Phase 8 — Security & quality verification ☐
- **Objective:** Review Rules + App Check; run tests/analyze/format; secret scan; listener-lifecycle review; Firestore cost review; accessibility; regression review.
- **Manual Firebase:** register App Check (Play Integrity) + SHA-256; stage enforcement after token validation; set usage alerts.

---
## Decisions — resolved / open
1. ☑ **Canonical Firebase project** — `super-vicky-222ec` (confirmed by user; the earlier `740f6`/`1d0c3`/placeholder references are superseded; `.firebaserc`/`firebase.json` regenerated to 222ec).
2. ☑ **Android application ID** — `super.vicky` (matches google-services.json `package_name`); code namespace `com.supervicky` (keyword-safe).
3. ☑ **Currency** — display **`R$` (Brazilian Real)** (user decision). Note: internal storage must still move to precise minor units (Phase 4), independent of the display symbol.
4. ☐ **Open business rules** in `BUSINESS_RULES.md` (Code uniqueness, Model source, timestamp modeling, period aggregation) — still open.

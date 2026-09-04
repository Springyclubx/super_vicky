# CLAUDE.md — Non-negotiable rules for the `super_vicky` project

This file governs all work by Claude Code and every subagent. It is authoritative. When a request conflicts with these rules, stop and surface the conflict rather than silently violating a rule.

## 0. Golden rules
- The **existing codebase is the source of truth**. Do not rewrite from scratch or swap architectures by preference.
- Understand before changing. Never make broad changes before reading the affected code.
- Never invent business rules. Label every assumption as `INFERRED` and record open questions.
- When uncertain, choose the **safest reversible** option and document the uncertainty.

## 1. Architecture
- Style: aspirational **Clean Architecture** with `lib/domain` (entities/constants) and `lib/infrastructure` (presentation + util). Preserve this split.
- **Dependency direction**: `lib/domain` must not import `package:flutter/material.dart` or Firebase implementation types. Firebase types (`User`, `Timestamp`, `DocumentSnapshot`) must not leak into domain entities.
- Widgets must **never** touch Firebase directly. UI → state (`ChangeNotifier`) → repository → Firebase.
- No business logic in UI classes. Monetary/total math lives outside visual widgets.
- No god `Service`/`utils` class. Prefer small, explicit, single-responsibility classes over speculative abstractions.

## 2. State management
- Use **`provider` + `ChangeNotifier`** — the convention already in the repo (`AuthProvider`, `FormDataState`, `ProductListState`). Do not introduce Bloc/Riverpod/GetX.

## 3. Naming (suffixes are mandatory)
- Visual component → `Widget`. Data model → `Model` (this project uses `Model` for domain entities). Service → `Service`. Repository abstraction → `Repository`; implementation → `RepositoryImpl`. Use case → `UseCase`. Data source → `DataSource`. Mapper → `Mapper`. Validator → `Validator`. Controller → `Controller`.
- Screens use the **`Screen`** suffix. **Do not** introduce `Page` (the convention is `Screen`).
- State classes keep the existing convention: `Provider` or `...State` extending `ChangeNotifier`.
- Filenames are `snake_case`, named after the primary class. Rename only when safe and low-churn; document naming violations before fixing them.

## 4. THE ABSOLUTE WIDGET RULE
- **No function, method, or getter may return `Widget` or `List<Widget>`.** The only permitted `Widget`-returning function is the framework override `Widget build(BuildContext context)`.
- Extract visual sections into dedicated classes ending in `Widget`. Prefer private (`_XxxWidget`) when used in one feature; public only when genuinely reused.
- Existing violations to fix when touched: `appBarDefault(...)` (returns `PreferredSizeWidget`).
- Use `const` constructors wherever possible. Keep `build` free of business logic.

## 5. Firebase & security
- Firebase must initialize **exactly once** (in `main.dart` via `firebase_options.dart`). One project across all config files.
- Auth: **email/password only**. No public registration screen unless code proves one is required. Observe `authStateChanges()`. Logout must clear session state.
- **App Check**: Play Integrity for Android release; debug provider for dev/CI. Never enable enforcement until debug + release clients can obtain valid tokens.
- **Firestore Security Rules**: deny-by-default. Never `allow read, write: if true;`. Validate auth, ownership, field names/types/ranges, immutability, and per-op authorization. Client validation is UX only; Rules are security.
- Never place API keys, tokens, passwords, service-account material, or full `google-services.json` contents into docs, logs, or code comments.
- Never run the Firebase Admin SDK or embed a service-account key in the Flutter client.
- Never log passwords, tokens, credentials, or sensitive documents.

## 6. Money & dates
- Do **not** store a currency-formatted string as the numeric source of truth. Persist a precise representation (integer minor units / cents preferred). Format for display only at the presentation layer.
- `total value = quantity × unit value`, computed in domain/application logic, read-only in UI, recalculated (not trusted from client) where feasible. Define and document a rounding policy.
- Store dates/timestamps in a sortable, queryable form (prefer Firestore server timestamps for ordering). Format per locale only at presentation. Avoid timezone date shifts.

## 7. Localization & theme
- Support locales **pt** and **en** (es scaffolding exists). Once localization is wired, no hardcoded user-facing strings in widgets. Persist selected language locally.
- Support Light / Dark / System; persist locally via the lightest existing local-persistence method. Centralize colors in `ColorDefaultConstants`; no scattered color literals.
- **Fixed value — never change**: dark-theme primary `Color(0xFFFA8072)`.

## 8. Code safety & git
- Inspect `git status` before editing. Never overwrite unrelated uncommitted user changes; there is currently a stash and modified `pubspec.yaml`.
- Never run destructive git (`reset --hard`, force checkout, force push). Never commit/push unless explicitly requested.
- Never change package name, application ID, Firebase project ID, signing config, or bundle ID without explicit approval.
- Never disable/suppress lint rules or swallow exceptions to make analysis pass. Use null safety and explicit error handling. Do not expose raw Firebase exceptions to users. No placeholder passed off as complete.

## 9. Testing (before declaring a phase complete)
- Run: `dart format --output=none --set-exit-if-changed .`, `flutter analyze`, `flutter test`, and Android build validation when feasible. Report honestly which ran and which did not — never claim an unrun command passed.
- Add meaningful tests (not implementation echoes) for money math, validation, date/time pre-population, persistence, auth state, mapping/serialization, and Security Rules (Emulator Suite).

## 10. Workflow
- Work in phases (see `docs/IMPLEMENTATION_PLAN.md`). Before a phase: state what/why/files/risks/tests. After a phase: state files changed, behavior changed, tests run, remaining warnings, manual user actions, assumptions introduced.
- Do not mix unrelated refactors with features. Do not mass-upgrade dependencies. Do not do project-wide renames unless necessary.

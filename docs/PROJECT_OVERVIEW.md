# PROJECT_OVERVIEW.md

> Status: audited 2026-07-29 (Phase 0/1). Based strictly on repository evidence. Items that could not be confirmed from code are marked `INFERRED` or `OPEN`.

## Purpose (evidence-based)
`super_vicky` is a Flutter application for **registering and listing product entries**. Each entry (`ProductModel`) captures an hour, date, model, code, quantity, and unit value, with a derived total (`quantity × value`). Entries are grouped into periods (`CloseProductsModel`, with start/end dates and an optional `person`). The main screen lists grouped entries; a form screen registers a new entry. `INFERRED`: this is a lightweight sales/stock/order bookkeeping tool for a single operator. The domain vocabulary (`Modelo`, `Código`, `Quantidade`, `Valor`) and default currency `R$` suggest a **Brazilian Portuguese** primary audience.

## Existing features
- **Product list** (`main_screen.dart`) — expandable period cards → product rows. **Currently backed by hardcoded mock data** in `ProductListState`; no Firestore reads yet.
- **Registration form** (`form_data_screen.dart`) — Hour, Date, Model, Code, Quantity, Value, Total value. Date/hour pre-populate to "now"; total auto-computes from quantity × value. **Form has no submit/persist action** — entered data is not saved anywhere.
- **Login** (`login_screen.dart`) — email/password via `AuthProvider` (Firebase Auth). No registration, no password reset, no email verification.
- **Theming** — `ColorDefaultConstants` defines light/dark palettes; `main.dart` builds a Material theme. No user-facing theme switch yet; dark/light is chosen from platform brightness via `context.isDarkTheme`.
- **Localization scaffolding** — `intl`-generated delegates for en/pt/es exist, but the `.arb` source files are **empty** and no UI string uses them.

## Existing screens
- `MainScreen` (route `''`) — list + FAB to add.
- `RegisterScreen` (route `/form`) — the registration form.
- `LoginScreen` — shown when unauthenticated (via `MainScreen`'s auth `Consumer`).

## Current technologies
- Flutter 3.32.0 / Dart 3.8.0. Provider `^6.1.5`, intl `^0.20.2`, logger `^2.6.1`.
- Firebase: `firebase_core ^4.2.1`, `firebase_auth ^6.1.2`, `cloud_firestore ^6.1.0` (Firestore declared but **not yet used** in code).
- Fonts: Inter family. Firebase CLI 15.5.1 available locally.

## State management
`provider` + `ChangeNotifier`. Three states: `AuthProvider` (auth), `FormDataState` (form controllers + total calc), `ProductListState` (mock list).

## Firebase services (current)
- **Auth**: email/password sign-in implemented; `authStateChanges()` observed.
- **Firestore**: dependency present, **no repository/data source, no reads or writes**. All list data is mock.
- **App Check**: not present (no `firebase_app_check` dependency).
- Init in `main.dart` uses `firebase_options.dart` `android` constant — see the critical config issue below.

## Architectural structure
```
lib/
  domain/
    constants/            format_date_constants, route_default
    entities/             product_model, close_products_model, person_model/*  (suffix: Model)
  extension/              context_util, string_util, util (date format/parse + logger)
  generated/              intl generated delegates (en/es/pt)
  infrastructure/
    presentation/
      constants/          color_default_constants, text_constants
      screens/            main_screen (+ part widgets), form_data, login_screen
      states/             login_state (AuthProvider), form_data_state, product_list_state
    util/                 app_bar_default, text_form_default, formatters/*, methods/*
    routes.dart
  l10n/                   intl_en/es/pt.arb (EMPTY)
  main.dart, firebase_options.dart
```
The folder names imply Clean Architecture, but there is **no data layer** (no repositories, data sources, use cases, or mappers) and entities carry no serialization. It is effectively presentation + a couple of domain entities.

## Known unfinished areas
- Firestore is unused; list is mock; the form does not persist.
- Localization `.arb` files are empty; all UI strings are hardcoded Portuguese.
- No theme/language switch UI; no local preference persistence.
- No tests (`test/` directory absent).
- `firebase_options.dart` (committed) contains **placeholder** values.

## Known technical debt / bugs (observed, not yet fixed)
- **Nested `MaterialApp`**: `HomePage` (main.dart) and `MainScreen` each build a `MaterialApp`; the inner one discards the outer theme/localization/routes.
- **Firebase init will fail as committed**: `main.dart` calls `Firebase.initializeApp(options: android)` where `android` has placeholder values (`projectId: 'seu-projeto-id'`).
- `ProductModel.createdHour` uses format `'HH:dd'` (hour:day-of-month) — almost certainly meant `'HH:mm'`.
- `CloseProductsModel` date getters use `'dd/MM/yyy'` (three `y`s).
- Money is a `double` and the source of truth for value is the formatted controller string; `FormDataState._multiplyQuantityByValue` `int.parse`s quantity and re-parses the currency string — fragile with thousands separators / decimals.
- `appBarDefault(...)` is a function returning a widget (violates the absolute widget rule).
- Hardcoded strings (`'sem titulo'`, `'Registro'`, etc.) and mixed currency (`R$` in code vs the request to show `$`).

## Mobile target
Android mobile is the primary and only current target. `minSdk = 32` (unusually high). iOS/macOS options exist in the stashed `firebase_options.dart` but are not a current requirement.

## Web considerations
- Web is **not** a current requirement. The stashed `firebase_options.dart` throws `UnsupportedError` for web.
- If web is added later: Firebase App Check on web uses **reCAPTCHA** (v3 / Enterprise), not Play Integrity — which reintroduces the billing considerations documented in `FIREBASE_AND_SECURITY.md`. Firestore offline persistence and some auth-persistence behaviors also differ on web.

# BUSINESS_RULES.md

> Rules are split into **Confirmed** (backed by `file:line`), **Inferred** (reasonable but unproven — never treat as fact), and **Open questions**. Never silently promote an inferred rule to confirmed.

## Authentication
**Confirmed**
- Sign-in is Firebase **email/password** (`login_state.dart:52`).
- Auth state is observed via `authStateChanges()` and drives UI (`login_state.dart:14`; `main_screen.dart:30`).
- Logout calls `signOut()` (`login_state.dart:63`).
- No registration, password-reset, or email-verification code exists anywhere.

**Inferred**
- `INFERRED`: users are provisioned manually in the Firebase Console (no in-app signup). Matches the intended direction.
- `INFERRED`: unauthenticated users should see only the login screen; the gate exists but is currently bypassed by the nested-`MaterialApp` bug and the placeholder Firebase config.

**Open**
- Should sessions persist across restarts (Firebase default = yes)? Confirm desired behavior.
- Are there roles/permissions (admin vs operator)? No evidence in code.

## Form fields
### Hour
- **Confirmed**: pre-populated to device now in `HH:mm` (`form_data_state.dart:49`, `FormatDate.hourMinute`). Editable text field with `HourInputFormatter` (`form_data_screen.dart:108`).
- **Open**: is Hour meant to be the current device time or a business-defined time? Should it be editable? Should it be stored as part of a structured timestamp rather than a display string?

### Date
- **Confirmed**: pre-populated to device now in `dd/MM/yyyy` (`form_data_state.dart:48`). Editable via text + a date picker limited to `[2000-01-01 .. today]` (`form_data_screen.dart:137-145`).
- **Inferred**: `INFERRED` future dates are disallowed (picker `lastDate: now`), but the free-text field is not similarly constrained.
- **Open**: should Date and Hour be one timestamp? Confirm no future dates allowed.

### Model
- **Confirmed**: free-text field, no validation, no option source (`form_data_screen.dart:156-168`).
- **Open**: should Model be a constrained/selectable list? From where? Currently anything is accepted. Do not invent options.

### Code
- **Confirmed**: free-text field, no validation, no uniqueness enforcement (`form_data_screen.dart:170-182`).
- **Open**: must Code be unique? If so, unique globally / per user / per date / per model? No evidence — do not assume.

### Quantity
- **Confirmed**: numeric only (`FilteringTextInputFormatter.digitsOnly`, `form_data_screen.dart:195`) — integers only as entered. Parsed as `int` (`form_data_state.dart:79`). `ProductModel.quantity` is typed `double`.
- **Inferred**: `INFERRED` quantity is a whole number in practice (digits-only input). Zero/negative are not currently rejected (digits-only prevents `-`, but `0` is allowed).
- **Open**: confirm integer-only and reject zero.

### Value (unit price)
- **Confirmed**: currency-formatted input via `CurrencyTextInputFormatter` using `R$` / `pt_BR` (`currency_input_formatter.dart:8-11`); default text `R$ 0,00` (`text_constants.dart:4`). Stored/consumed as a formatted **string** in the controller; converted to `double` on demand (`extractor_number_per_string_parse.dart:34`).
- **Observed bug**: value is a `double` and the source of truth is the formatted string — violates precise-money handling; `extractValue` mishandles thousands separators.
- **Request vs code**: the task asks for a `$` prefix; current code uses `R$`. Reconcile with the product owner (locale-dependent). **Open**.

### Total value
- **Confirmed**: `total = quantity × unit value`, recomputed reactively when quantity or value changes (`form_data_state.dart:52-71`); the field is read-only (`enabled: false`, `form_data_screen.dart:226`). Currently recomputed on every keystroke (local only — not written to Firebase).
- **Observed bug**: parsing is fragile (int quantity × string-parsed value); `ProductModel.totalValue` returns `(quantity * value).toString()` with no rounding policy.
- **Rules to enforce going forward**: calculation outside the visual widget (already true in state), precise monetary representation, defined rounding policy, tests for decimals/zero/invalid/large/locale, no per-keystroke Firebase writes, server-side recalculation/validation where feasible.

## Period grouping (`CloseProductsModel`)
- **Confirmed**: groups a list of `ProductModel` with optional `startDate`, `endDate`, `person`; `valorTotal` sums `item.value` (unit values, **not** quantity×value) (`close_products_model.dart:38-46`).
- **Observed**: `valorTotal` likely should sum totals, not unit values. **Open** — confirm intended aggregation.

## Theme
- **Confirmed**: light/dark palettes defined; selection follows platform brightness (`color_default_constants.dart`). Dark primary is fixed at `Color(0xFFFA8072)`.
- **Required (task)**: user-selectable Light/Dark/System, persisted locally. Not yet implemented.

## Language / localization
- **Confirmed**: en/pt/es delegates generated; `.arb` files empty; UI strings hardcoded Portuguese.
- **Required (task)**: user-selectable pt/en, persisted locally, safe fallback; locale affects date/time/decimal/money formatting only — never business meaning.

## Data ownership (Firestore)
- **Confirmed**: none — Firestore is unused; list is mock.
- **Required going forward**: entries owned per authenticated user (`uid`), enforced by Security Rules. See `FIREBASE_AND_SECURITY.md` and `DECISIONS.md`. Do not assume cross-user sharing without product confirmation.

## Cross-cutting open questions
1. Is Code required to be unique, and at what scope?
2. Are Model values constrained to a known list, and where does it come from?
3. Currency symbol: `$` (task) vs `R$` (code) — which locale is authoritative?
4. Should Hour+Date be a single stored timestamp?
5. Intended aggregation for a period's total.
6. Any roles/permissions beyond a single operator?

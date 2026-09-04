# ARCHITECTURE.md

> Describes the architecture **as it exists today** plus the target conventions to grow into. Preserve existing conventions; do not swap paradigms.

## Layers (current)
- **domain/** — `entities/` (suffix `Model`) and `constants/`. Pure Dart today, but `close_products_model.dart` imports an extension that uses `intl` (formatting leaking into domain — debt).
- **infrastructure/presentation/** — `screens/`, `states/` (Provider `ChangeNotifier`), `constants/` (colors/text).
- **infrastructure/util/** — shared widgets, formatters, date-picker method, default app bar.
- **extension/** — `BuildContext`/`String` helpers and date format/parse + logger.
- **Missing layer**: there is **no data layer** (no repositories, data sources, use cases, mappers, DTOs). Firestore is not wired.

## Target layer additions (introduce incrementally, only when wiring Firestore)
```
domain/
  entities/            *_model.dart            (domain models, no Firebase types)
  repositories/        *_repository.dart       (abstract interfaces)
infrastructure/
  data/
    datasources/       *_data_source.dart      (Firestore access)
    models/            *_dto.dart or reuse     (serialization boundary)
    mappers/           *_mapper.dart           (DTO <-> entity)
    repositories/      *_repository_impl.dart  (implements domain repository)
```
Rationale: keeps widgets and states free of Firestore, allows a future backend swap, and gives Security-Rule-aligned serialization one home.

## Folder responsibilities
- `screens/<feature>/` — one screen + its private `part` widgets under `widget/`.
- `states/` — one `ChangeNotifier` per feature; holds controllers and derived values; no direct Firebase access once repositories exist (inject a repository).
- `util/` — genuinely shared, feature-agnostic helpers only. Not a dumping ground.

## Dependency direction (enforced)
`presentation` → `domain` (entities + repository interfaces). `data` → `domain`. `domain` depends on **nothing** Flutter/Firebase. Widgets never import `cloud_firestore`/`firebase_auth` directly. Firebase types never appear in `domain/entities`.

## Naming conventions
See `CLAUDE.md §3`. Key points: `Widget` / `Model` / `Service` / `Repository` / `RepositoryImpl` / `UseCase` / `DataSource` / `Mapper` / `Validator` / `Controller`; **`Screen` not `Page`**; states are `Provider`/`...State`. Files `snake_case`, named for their primary class.

## State-management conventions
`provider` + `ChangeNotifier`, provided at the screen boundary via `ChangeNotifierProvider` (e.g. `RegisterScreen` creates `FormDataState`). Read with `Provider.of<T>(context)`; use `listen: false` for actions. Dispose controllers in `ChangeNotifier.dispose` (currently **not** disposed — debt to fix).

## Repository conventions (target)
- Abstract `XxxRepository` in `domain/repositories`; `XxxRepositoryImpl` in `data/repositories` wrapping a `XxxDataSource`.
- Repositories return domain entities (or a typed failure), never raw `DocumentSnapshot`.
- Expose `Stream<...>` only where realtime is justified (see `FIREBASE_COST_STRATEGY.md`).

## Error-handling conventions
- Current: `AuthProvider` catches `FirebaseAuthException` and stores `errorMessage`; date helpers catch `FormatException` and log via `logger`.
- Target: map Firebase exceptions to a small typed failure (or user-safe message) at the repository boundary. Never surface raw exception text to users. Never swallow exceptions silently. Never log secrets/credentials/tokens.

## Navigation conventions
Named routes in `routes.dart` keyed by `RouteDefault` (`mainScreen = ''`, `formScreen = '/form'`). Navigate with `Navigator.pushNamed`. Note: `RouteDefault.mainScreen` is an empty string while `MaterialApp` also sets `home:` — reconcile (see debt below).

## Widget extraction rules
Absolute widget rule (`CLAUDE.md §4`): no function/method/getter returns `Widget`; extract into a `...Widget` class. Private `_XxxWidget` for single-feature use (see `main_screen`'s `part` widgets); public only when reused. `const` constructors mandatory where possible.

## Data flow (UI → Firebase, target)
`Widget` → reads/acts on `ChangeNotifier` state → state calls injected `Repository` → `RepositoryImpl` → `DataSource` → Firestore. Reverse for reads: Firestore snapshot → mapper → entity → state → widget.

## Local / offline strategy
- User **preferences** (theme, language): lightest local persistence (add `shared_preferences`). Decision pending in `DECISIONS.md`.
- Business data offline: prefer **Firestore native offline persistence** first; do not add a second database (Drift/Isar/Hive/SQLite) without a documented sync strategy. See `DECISIONS.md`.

## Known architectural debt (fix during stabilization, per plan)
1. Nested `MaterialApp` (main.dart + main_screen.dart) — keep exactly one.
2. `main.dart` both sets `home:` and `initialRoute: ''` with named routes — pick one navigation model.
3. `appBarDefault(...)` function returning a widget → convert to an `AppBarDefaultWidget`/`PreferredSizeWidget` class.
4. Formatting/`intl` leaking into `domain` entities.
5. `TextEditingController`s never disposed in states.
6. Placeholder `firebase_options.dart` used by `main.dart`.

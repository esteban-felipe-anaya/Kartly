# 🛒 Kartly

A polished, **cross-platform Material 3 e-commerce app** built with Flutter — running from a
single codebase on **iOS, Android, Web, macOS, Windows, and Linux**. It ships with a runnable
**mock REST API** and consumes it through a proper Dio + Retrofit + repository layer (no
hardcoded data in the UI). Every flow is wired end to end.

- **Brand color:** commerce purple `#6750A4` (drives the M3 `ColorScheme.fromSeed`)
- **State:** Riverpod (codegen) · **Routing:** go_router · **Models:** freezed + json_serializable
- **Networking:** Dio + Retrofit with auth, logging, and latency/error-simulation interceptors

---

## ✨ Features

- **Material 3 / Material You** throughout: `NavigationBar`/`NavigationRail`, `SearchBar`,
  `FilledButton`, `Card`, `FilterChip`, `SegmentedButton`, `Badge` cart count, M3 bottom sheets,
  tonal surfaces, full light/dark themes, and **platform dynamic color** (falls back to the seed
  scheme where unavailable).
- **Adaptive & responsive:** bottom `NavigationBar` on mobile, compact `NavigationRail` on
  tablet, extended rail + persistent **cart side panel** on desktop; product grid scales 2 → 3 →
  4+ columns.
- **Full integration:** browse → product detail → **add to cart** → cart badge updates → cart →
  **checkout** (auth-gated) → place order → order appears in **history**. Cart persists locally
  and syncs to the API, supports quantity edits, removal, and **promo codes**. Wishlist toggle
  persists. Search + filters + sort actually query the API. Address-book CRUD feeds the checkout
  address selector. Theme mode and locale persist across launches.
- **Real loading / empty / error states** everywhere (shimmer skeletons, retry views), made
  visible by an interceptor that injects 300–800 ms latency and occasional transient failures.

---

## 🚀 Quick start

### 1. Run the mock API

```bash
cd mock-api
npm install
npm run dev          # seeds db.json + serves http://localhost:3000
```

(See [`mock-api/README.md`](mock-api/README.md) for endpoints and seed details.)

### 2. Run the Flutter app

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # generate freezed/json/retrofit/riverpod code
flutter run -d chrome        # or: macos / windows / linux / <device-id>
```

> **Codegen:** the project uses `freezed`, `json_serializable`, `retrofit`, and
> `riverpod_generator`. Run the `build_runner` command above after a fresh clone or whenever you
> change a model/provider/API definition. Use `dart run build_runner watch` during development.

**Demo credentials:** `demo@kartly.app` / `password123`
**Promo codes:** `WELCOME10`, `KARTLY15`, `SAVE20`

---

## 🌐 Configuring the API base URL

The base URL defaults to `http://localhost:3000`. Override it at run/build time with a Dart
define:

```bash
flutter run --dart-define=KARTLY_API_BASE_URL=http://localhost:3000
```

| Target | Base URL to use |
|--------|-----------------|
| Web, desktop (macOS/Windows/Linux), iOS Simulator | `http://localhost:3000` (default) |
| **Android emulator** | `http://10.0.2.2:3000` (the host loopback alias) |
| Physical device | `http://<your-machine-LAN-IP>:3000` |

You can also disable the simulated latency/errors:

```bash
flutter run --dart-define=KARTLY_SIMULATE_NETWORK=false
```

---

## 🖥️ Running on each platform

The same codebase runs everywhere with no code changes:

```bash
# Web
flutter run -d chrome
flutter build web

# Android (emulator → use 10.0.2.2)
flutter run -d emulator-5554 --dart-define=KARTLY_API_BASE_URL=http://10.0.2.2:3000
flutter build apk

# iOS (macOS host)
flutter run -d <ios-simulator>
flutter build ios

# Desktop
flutter run -d macos      # flutter build macos
flutter run -d windows    # flutter build windows
flutter run -d linux      # flutter build linux
```

List available targets with `flutter devices`. Desktop targets may require enabling once via
`flutter config --enable-<platform>-desktop`.

---

## 🧱 Architecture

Feature-first clean architecture. Repositories expose domain (freezed) models; Riverpod
controllers hold UI/cart state and call repositories. JSON shapes never reach the UI.

```
lib/
  core/
    env/            # runtime config (API base URL, network simulation flag)
    network/        # Dio client, interceptors, typed AppException, guard()
    providers/      # DI: dio, api, repositories (Riverpod codegen)
    router/         # go_router config + route-path constants
    storage/        # secure token store + shared_preferences wrapper
    theme/          # design tokens + centralized Material 3 ThemeData
    utils/          # formatters (intl), responsive breakpoints
  data/
    models/         # freezed + json_serializable domain models
    api/            # Retrofit KartlyApi (1:1 with the contract)
    repositories/   # repository implementations
  features/
    auth/  home/  catalog/  search/  product/  cart/  checkout/
    orders/  wishlist/  account/  notifications/  onboarding/
        application/    # Riverpod controllers / providers
        presentation/   # screens & feature widgets
  shared/widgets/   # product card/grid/rail, price tag, qty stepper, rating,
                    # empty/error/loading states, adaptive nav scaffold, app buttons
  app.dart          # MaterialApp.router + dynamic color + theme/locale
  main.dart         # bootstrap (SharedPreferences) + ProviderScope
mock-api/           # json-server: db.json, routes.json, server.js, generators
```

### State & integration highlights

- **Cart** (`CartController`, keepAlive) syncs to the API and mirrors to `shared_preferences`, so
  it survives restarts and brief offline periods. Totals (subtotal, discount, shipping, tax,
  total) are computed by the pure, unit-tested `computeCartTotals`.
- **Auth** restores a session from a securely stored token on launch; only **checkout** is
  gated, redirecting to login with a return path and back.
- **Wishlist** updates optimistically and rolls back on failure.
- **Theme & locale** are persisted and applied app-wide; dynamic color is harmonized with the
  brand seed.

---

## ✅ Quality

```bash
flutter analyze         # zero issues
flutter test            # cart totals (incl. promo), add-to-cart flow, repository (mocked Dio)
```

- Strong typing via freezed; centralized typed error handling with graceful error UI.
- Currency/dates always go through `intl`-based `Formatters`.
- Lint-clean (`flutter_lints`) with `prefer_single_quotes`, `require_trailing_commas`, and
  ordered imports enforced.
- Reusable `shared/` widgets — no copy-pasted UI.

---

## 📦 Tech stack

| Concern | Package |
|---------|---------|
| State management | `flutter_riverpod`, `riverpod_annotation` (codegen) |
| Routing | `go_router` (shell route, deep links, auth redirect) |
| Networking | `dio`, `retrofit`, `pretty_dio_logger` |
| Models | `freezed`, `json_serializable` |
| Dynamic color | `dynamic_color` |
| Images | `cached_network_image` |
| UI helpers | `flutter_rating_bar`, `carousel_slider`, `shimmer` |
| Storage | `flutter_secure_storage` (token), `shared_preferences` (theme/locale/cart) |
| Formatting | `intl` |
| Testing | `flutter_test`, `mocktail` |

---

## 🛠️ Troubleshooting

- **Android build fails with `Could not close incremental caches … is already registered`** — a
  Kotlin Build Tools API daemon bug (most common on Windows) where memory-mapped incremental
  cache files can't be released. Kartly already sets `kotlin.incremental=false` and
  `kotlin.compiler.execution.strategy=in-process` in [`android/gradle.properties`](android/gradle.properties)
  to avoid it. If you still hit it: `./android/gradlew --stop && flutter clean && flutter pub get`,
  then rebuild.
- **Symlink/Developer Mode warning on Windows** — enable Developer Mode (`start ms-settings:developers`)
  so plugin builds can create symlinks.
- **Wasm dry-run warnings on `flutter build web`** — informational only; `flutter_secure_storage`'s
  web plugin isn't WebAssembly-ready. The default JS web build is unaffected.

## 🔁 Regenerating code

After changing any `@freezed`, `@JsonSerializable`, Retrofit `@RestApi`, or `@riverpod`
declaration:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Generated files (`*.freezed.dart`, `*.g.dart`) are excluded from analysis.

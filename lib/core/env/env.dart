/// Runtime environment configuration.
///
/// The API base URL can be overridden at build/run time:
///   flutter run --dart-define=KARTLY_API_BASE_URL=http://10.0.2.2:3000
///
/// Defaults to localhost:3000 (works on web, desktop, and iOS simulator).
/// Android emulators must use 10.0.2.2 to reach the host machine.
class Env {
  const Env._();

  static const String apiBaseUrl = String.fromEnvironment(
    'KARTLY_API_BASE_URL',
    defaultValue: 'http://localhost:3000',
  );

  /// When true, the [LatencyErrorInterceptor] injects artificial latency and
  /// occasional failures so loading/error states are exercised in development.
  static const bool simulateNetworkConditions = bool.fromEnvironment(
    'KARTLY_SIMULATE_NETWORK',
    defaultValue: true,
  );
}

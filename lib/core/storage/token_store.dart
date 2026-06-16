import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Persists the auth token securely and caches it in memory so the Dio
/// [AuthInterceptor] can read it synchronously.
class TokenStore {
  TokenStore(this._storage);

  static const _key = 'kartly_auth_token';
  final FlutterSecureStorage _storage;
  String? _cached;

  String? get cached => _cached;

  Future<String?> read() async {
    _cached ??= await _storage.read(key: _key);
    return _cached;
  }

  Future<void> write(String token) async {
    _cached = token;
    await _storage.write(key: _key, value: token);
  }

  Future<void> clear() async {
    _cached = null;
    await _storage.delete(key: _key);
  }
}

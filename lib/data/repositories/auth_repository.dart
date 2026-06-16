import '../../core/network/api_guard.dart';
import '../api/kartly_api.dart';
import '../models/auth.dart';
import '../models/user.dart';

class AuthRepository {
  AuthRepository(this._api);

  final KartlyApi _api;

  Future<AuthResponse> login(String email, String password) =>
      guard(() => _api.login({'email': email, 'password': password}));

  Future<AuthResponse> register(String name, String email, String password) =>
      guard(() => _api.register({'name': name, 'email': email, 'password': password}));

  Future<User> me() => guard(() => _api.me()).then((r) => r.user);
}

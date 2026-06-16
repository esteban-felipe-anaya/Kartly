import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/api/kartly_api.dart';
import '../../data/repositories/address_repository.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/cart_repository.dart';
import '../../data/repositories/catalog_repository.dart';
import '../../data/repositories/notification_repository.dart';
import '../../data/repositories/order_repository.dart';
import '../../data/repositories/wishlist_repository.dart';
import '../network/dio_client.dart';
import '../storage/local_prefs.dart';
import '../storage/token_store.dart';

part 'core_providers.g.dart';

/// Overridden in `main()` with the resolved [SharedPreferences] instance.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) =>
    throw UnimplementedError('sharedPreferencesProvider must be overridden in main()');

@Riverpod(keepAlive: true)
LocalPrefs localPrefs(Ref ref) => LocalPrefs(ref.watch(sharedPreferencesProvider));

@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(Ref ref) => const FlutterSecureStorage();

@Riverpod(keepAlive: true)
TokenStore tokenStore(Ref ref) => TokenStore(ref.watch(secureStorageProvider));

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final tokenStore = ref.watch(tokenStoreProvider);
  return createDio(tokenReader: () => tokenStore.cached);
}

@Riverpod(keepAlive: true)
KartlyApi kartlyApi(Ref ref) => KartlyApi(ref.watch(dioProvider));

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => AuthRepository(ref.watch(kartlyApiProvider));

@Riverpod(keepAlive: true)
CatalogRepository catalogRepository(Ref ref) =>
    CatalogRepository(ref.watch(kartlyApiProvider));

@Riverpod(keepAlive: true)
CartRepository cartRepository(Ref ref) => CartRepository(ref.watch(kartlyApiProvider));

@Riverpod(keepAlive: true)
WishlistRepository wishlistRepository(Ref ref) =>
    WishlistRepository(ref.watch(kartlyApiProvider));

@Riverpod(keepAlive: true)
AddressRepository addressRepository(Ref ref) =>
    AddressRepository(ref.watch(kartlyApiProvider));

@Riverpod(keepAlive: true)
OrderRepository orderRepository(Ref ref) => OrderRepository(ref.watch(kartlyApiProvider));

@Riverpod(keepAlive: true)
NotificationRepository notificationRepository(Ref ref) =>
    NotificationRepository(ref.watch(kartlyApiProvider));

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/account/presentation/account_screen.dart';
import '../../features/account/presentation/address_form_screen.dart';
import '../../features/account/presentation/addresses_screen.dart';
import '../../features/account/presentation/payment_methods_screen.dart';
import '../../features/account/presentation/settings_screen.dart';
import '../../features/auth/application/auth_controller.dart';
import '../../features/auth/presentation/forgot_password_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/cart/presentation/cart_screen.dart';
import '../../features/catalog/presentation/catalog_screen.dart';
import '../../features/checkout/presentation/checkout_screen.dart';
import '../../features/checkout/presentation/order_success_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/notifications/presentation/notifications_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/onboarding/presentation/splash_screen.dart';
import '../../features/orders/presentation/order_detail_screen.dart';
import '../../features/orders/presentation/orders_screen.dart';
import '../../features/product/presentation/product_detail_screen.dart';
import '../../features/search/presentation/search_screen.dart';
import '../../features/wishlist/presentation/wishlist_screen.dart';
import '../../shared/widgets/app_scaffold.dart';
import 'route_paths.dart';

final _rootKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Bridges a Riverpod provider to a [Listenable] so go_router refreshes its
/// redirect logic whenever the watched provider changes.
class _RouterRefresh extends ChangeNotifier {
  _RouterRefresh(Ref ref, ProviderListenable<Object?> provider) {
    ref.listen(provider, (_, _) => notifyListeners());
  }
}

/// The application router. Browsing is allowed as a guest; checkout is the only
/// auth-gated destination and redirects to login with a return path.
final goRouterProvider = Provider<GoRouter>((ref) {
  final refresh = _RouterRefresh(ref, authControllerProvider);

  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: Routes.splash,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: refresh,
    redirect: (context, state) {
      final loggedIn = ref.read(authControllerProvider).valueOrNull != null;
      final location = state.matchedLocation;

      // Only checkout requires authentication.
      if (location == Routes.checkout && !loggedIn) {
        return '${Routes.login}?redirect=${Uri.encodeComponent(Routes.checkout)}';
      }
      return null;
    },
    routes: [
      GoRoute(path: Routes.splash, builder: (_, _) => const SplashScreen()),
      GoRoute(path: Routes.onboarding, builder: (_, _) => const OnboardingScreen()),
      GoRoute(
        path: Routes.login,
        builder: (_, state) =>
            LoginScreen(redirect: state.uri.queryParameters['redirect']),
      ),
      GoRoute(path: Routes.register, builder: (_, _) => const RegisterScreen()),
      GoRoute(
        path: Routes.forgotPassword,
        builder: (_, _) => const ForgotPasswordScreen(),
      ),

      // Detail / overlay routes (full screen, over the shell).
      GoRoute(
        path: '/product/:id',
        builder: (_, state) =>
            ProductDetailScreen(productId: state.pathParameters['id']!),
      ),
      GoRoute(path: Routes.cart, builder: (_, _) => const CartScreen()),
      GoRoute(path: Routes.checkout, builder: (_, _) => const CheckoutScreen()),
      GoRoute(
        path: '/order-success/:id',
        builder: (_, state) =>
            OrderSuccessScreen(orderId: state.pathParameters['id']!),
      ),
      GoRoute(path: Routes.orders, builder: (_, _) => const OrdersScreen()),
      GoRoute(
        path: '/orders/:id',
        builder: (_, state) =>
            OrderDetailScreen(orderId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: Routes.notifications,
        builder: (_, _) => const NotificationsScreen(),
      ),
      GoRoute(path: Routes.addresses, builder: (_, _) => const AddressesScreen()),
      GoRoute(
        path: Routes.addressNew,
        builder: (_, _) => const AddressFormScreen(),
      ),
      GoRoute(
        path: '/account/addresses/:id',
        builder: (_, state) =>
            AddressFormScreen(addressId: state.pathParameters['id']),
      ),
      GoRoute(
        path: Routes.paymentMethods,
        builder: (_, _) => const PaymentMethodsScreen(),
      ),
      GoRoute(path: Routes.settings, builder: (_, _) => const SettingsScreen()),

      // Primary navigation shell (5 branches).
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => AppNavigationScaffold(navigationShell: shell),
        branches: [
          StatefulShellBranch(
            routes: [GoRoute(path: Routes.home, builder: (_, _) => const HomeScreen())],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.catalog,
                builder: (_, state) => CatalogScreen(
                  categoryId: state.uri.queryParameters['categoryId'],
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: Routes.search, builder: (_, _) => const SearchScreen())],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: Routes.wishlist, builder: (_, _) => const WishlistScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: Routes.account, builder: (_, _) => const AccountScreen()),
            ],
          ),
        ],
      ),
    ],
  );
});

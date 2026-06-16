/// Centralized route paths and names for go_router. Screens reference these
/// constants instead of hardcoding path strings.
class Routes {
  const Routes._();

  static const splash = '/splash';
  static const onboarding = '/onboarding';

  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';

  static const home = '/home';
  static const catalog = '/catalog';
  static const search = '/search';
  static const wishlist = '/wishlist';
  static const account = '/account';

  // Catalog with a category filter: /catalog?categoryId=cat_audio
  static const cart = '/cart';
  static const checkout = '/checkout';

  static const orders = '/orders';
  static String orderDetail(String id) => '/orders/$id';
  static String orderSuccess(String id) => '/order-success/$id';

  static String product(String id) => '/product/$id';

  static const addresses = '/account/addresses';
  static const addressNew = '/account/addresses/new';
  static String addressEdit(String id) => '/account/addresses/$id';
  static const paymentMethods = '/account/payment-methods';
  static const settings = '/account/settings';
  static const notifications = '/notifications';
}

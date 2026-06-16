import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/address.dart';
import '../models/auth.dart';
import '../models/cart.dart';
import '../models/category.dart';
import '../models/home_banner.dart';
import '../models/notification.dart';
import '../models/order.dart';
import '../models/product.dart';
import '../models/promo.dart';
import '../models/review.dart';

part 'kartly_api.g.dart';

/// Typed Retrofit client mapping 1:1 to the Kartly mock API contract.
@RestApi()
abstract class KartlyApi {
  factory KartlyApi(Dio dio, {String? baseUrl}) = _KartlyApi;

  // ---- Auth ----
  @POST('/auth/login')
  Future<AuthResponse> login(@Body() Map<String, dynamic> body);

  @POST('/auth/register')
  Future<AuthResponse> register(@Body() Map<String, dynamic> body);

  @GET('/auth/me')
  Future<MeResponse> me();

  // ---- Home ----
  @GET('/banners')
  Future<List<HomeBanner>> getBanners();

  @GET('/categories')
  Future<List<Category>> getCategories();

  // ---- Catalog ----
  @GET('/products')
  Future<List<Product>> getProducts(@Queries() Map<String, dynamic> queries);

  @GET('/products/{id}')
  Future<Product> getProduct(@Path('id') String id);

  @GET('/products/{id}/reviews')
  Future<List<Review>> getReviews(@Path('id') String id);

  // ---- Cart ----
  @GET('/cart')
  Future<Cart> getCart();

  @POST('/cart/items')
  Future<Cart> addCartItem(@Body() Map<String, dynamic> body);

  @PATCH('/cart/items/{id}')
  Future<Cart> updateCartItem(@Path('id') String id, @Body() Map<String, dynamic> body);

  @DELETE('/cart/items/{id}')
  Future<Cart> removeCartItem(@Path('id') String id);

  @POST('/promo/validate')
  Future<PromoResult> validatePromo(@Body() Map<String, dynamic> body);

  // ---- Wishlist ----
  @GET('/wishlist')
  Future<List<String>> getWishlist();

  @POST('/wishlist')
  Future<void> addWishlist(@Body() Map<String, dynamic> body);

  @DELETE('/wishlist/{productId}')
  Future<void> removeWishlist(@Path('productId') String productId);

  // ---- Addresses ----
  @GET('/addresses')
  Future<List<Address>> getAddresses();

  @POST('/addresses')
  Future<Address> createAddress(@Body() Map<String, dynamic> body);

  @PUT('/addresses/{id}')
  Future<Address> updateAddress(@Path('id') String id, @Body() Map<String, dynamic> body);

  @DELETE('/addresses/{id}')
  Future<void> deleteAddress(@Path('id') String id);

  // ---- Orders ----
  @POST('/orders')
  Future<Order> createOrder(@Body() Map<String, dynamic> body);

  @GET('/orders')
  Future<List<Order>> getOrders();

  @GET('/orders/{id}')
  Future<Order> getOrder(@Path('id') String id);

  // ---- Notifications ----
  @GET('/notifications')
  Future<List<AppNotification>> getNotifications();
}

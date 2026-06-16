import '../../core/network/api_guard.dart';
import '../api/kartly_api.dart';
import '../models/category.dart';
import '../models/home_banner.dart';
import '../models/product.dart';
import '../models/product_query.dart';
import '../models/review.dart';

class CatalogRepository {
  CatalogRepository(this._api);

  final KartlyApi _api;

  Future<List<HomeBanner>> banners() => guard(() => _api.getBanners());

  Future<List<Category>> categories() => guard(() => _api.getCategories());

  Future<List<Product>> products(ProductQuery query) =>
      guard(() => _api.getProducts(query.toQueryMap()));

  Future<Product> product(String id) => guard(() => _api.getProduct(id));

  Future<List<Review>> reviews(String productId) =>
      guard(() => _api.getReviews(productId));
}

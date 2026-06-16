import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartly/core/providers/core_providers.dart';
import 'package:kartly/data/models/cart.dart';
import 'package:kartly/data/models/product.dart';
import 'package:kartly/data/repositories/cart_repository.dart';
import 'package:kartly/features/cart/application/cart_controller.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockCartRepository extends Mock implements CartRepository {}

const _product = Product(
  id: 'prd_1',
  title: 'Test Headphones',
  brand: 'Auralis',
  categoryId: 'cat_audio',
  price: 99.99,
);

void main() {
  late MockCartRepository repo;
  late ProviderContainer container;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    repo = MockCartRepository();

    // Start with an empty cart, then return a populated cart after add.
    when(() => repo.fetch()).thenAnswer((_) async => const Cart(items: []));
    when(
      () => repo.addItem(
        productId: any(named: 'productId'),
        variant: any(named: 'variant'),
        qty: any(named: 'qty'),
        priceAtAdd: any(named: 'priceAtAdd'),
      ),
    ).thenAnswer(
      (_) async => const Cart(
        items: [
          CartItem(id: 'ci_1', productId: 'prd_1', qty: 1, priceAtAdd: 99.99),
        ],
      ),
    );

    container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        cartRepositoryProvider.overrideWithValue(repo),
      ],
    );
    addTearDown(container.dispose);
  });

  test('add-to-cart flow updates cart state and badge count', () async {
    // Initial load: empty cart.
    final initial = await container.read(cartControllerProvider.future);
    expect(initial.items, isEmpty);
    expect(container.read(cartItemCountProvider), 0);

    // Add a product.
    await container.read(cartControllerProvider.notifier).addProduct(_product);

    final cart = container.read(cartControllerProvider).value!;
    expect(cart.items, hasLength(1));
    expect(cart.items.first.productId, 'prd_1');
    expect(container.read(cartItemCountProvider), 1);

    // The repository was asked to add the right product at its price.
    verify(
      () => repo.addItem(
        productId: 'prd_1',
        variant: const {},
        qty: 1,
        priceAtAdd: 99.99,
      ),
    ).called(1);
  });
}

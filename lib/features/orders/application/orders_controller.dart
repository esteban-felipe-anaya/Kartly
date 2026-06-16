import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/core_providers.dart';
import '../../../data/models/order.dart';

part 'orders_controller.g.dart';

@riverpod
class OrdersController extends _$OrdersController {
  @override
  Future<List<Order>> build() async {
    final orders = await ref.watch(orderRepositoryProvider).fetchAll();
    // Newest first.
    orders.sort((a, b) =>
        (b.createdAt ?? DateTime(0)).compareTo(a.createdAt ?? DateTime(0)));
    return orders;
  }
}

@riverpod
Future<Order> orderDetail(Ref ref, String id) =>
    ref.watch(orderRepositoryProvider).fetchOne(id);

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return _OrderItem.fromJson(json);
}

/// @nodoc
mixin _$OrderItem {
  String get productId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  Map<String, String> get variant => throw _privateConstructorUsedError;
  int get qty => throw _privateConstructorUsedError;
  double get priceAtAdd => throw _privateConstructorUsedError;

  /// Serializes this OrderItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderItemCopyWith<OrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemCopyWith<$Res> {
  factory $OrderItemCopyWith(OrderItem value, $Res Function(OrderItem) then) =
      _$OrderItemCopyWithImpl<$Res, OrderItem>;
  @useResult
  $Res call({
    String productId,
    String title,
    String? image,
    Map<String, String> variant,
    int qty,
    double priceAtAdd,
  });
}

/// @nodoc
class _$OrderItemCopyWithImpl<$Res, $Val extends OrderItem>
    implements $OrderItemCopyWith<$Res> {
  _$OrderItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? title = null,
    Object? image = freezed,
    Object? variant = null,
    Object? qty = null,
    Object? priceAtAdd = null,
  }) {
    return _then(
      _value.copyWith(
            productId: null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            image: freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String?,
            variant: null == variant
                ? _value.variant
                : variant // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
            qty: null == qty
                ? _value.qty
                : qty // ignore: cast_nullable_to_non_nullable
                      as int,
            priceAtAdd: null == priceAtAdd
                ? _value.priceAtAdd
                : priceAtAdd // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderItemImplCopyWith<$Res>
    implements $OrderItemCopyWith<$Res> {
  factory _$$OrderItemImplCopyWith(
    _$OrderItemImpl value,
    $Res Function(_$OrderItemImpl) then,
  ) = __$$OrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String productId,
    String title,
    String? image,
    Map<String, String> variant,
    int qty,
    double priceAtAdd,
  });
}

/// @nodoc
class __$$OrderItemImplCopyWithImpl<$Res>
    extends _$OrderItemCopyWithImpl<$Res, _$OrderItemImpl>
    implements _$$OrderItemImplCopyWith<$Res> {
  __$$OrderItemImplCopyWithImpl(
    _$OrderItemImpl _value,
    $Res Function(_$OrderItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? title = null,
    Object? image = freezed,
    Object? variant = null,
    Object? qty = null,
    Object? priceAtAdd = null,
  }) {
    return _then(
      _$OrderItemImpl(
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        image: freezed == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String?,
        variant: null == variant
            ? _value._variant
            : variant // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        qty: null == qty
            ? _value.qty
            : qty // ignore: cast_nullable_to_non_nullable
                  as int,
        priceAtAdd: null == priceAtAdd
            ? _value.priceAtAdd
            : priceAtAdd // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderItemImpl implements _OrderItem {
  const _$OrderItemImpl({
    required this.productId,
    this.title = '',
    this.image,
    final Map<String, String> variant = const <String, String>{},
    this.qty = 1,
    this.priceAtAdd = 0,
  }) : _variant = variant;

  factory _$OrderItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderItemImplFromJson(json);

  @override
  final String productId;
  @override
  @JsonKey()
  final String title;
  @override
  final String? image;
  final Map<String, String> _variant;
  @override
  @JsonKey()
  Map<String, String> get variant {
    if (_variant is EqualUnmodifiableMapView) return _variant;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_variant);
  }

  @override
  @JsonKey()
  final int qty;
  @override
  @JsonKey()
  final double priceAtAdd;

  @override
  String toString() {
    return 'OrderItem(productId: $productId, title: $title, image: $image, variant: $variant, qty: $qty, priceAtAdd: $priceAtAdd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderItemImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image) &&
            const DeepCollectionEquality().equals(other._variant, _variant) &&
            (identical(other.qty, qty) || other.qty == qty) &&
            (identical(other.priceAtAdd, priceAtAdd) ||
                other.priceAtAdd == priceAtAdd));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    productId,
    title,
    image,
    const DeepCollectionEquality().hash(_variant),
    qty,
    priceAtAdd,
  );

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      __$$OrderItemImplCopyWithImpl<_$OrderItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderItemImplToJson(this);
  }
}

abstract class _OrderItem implements OrderItem {
  const factory _OrderItem({
    required final String productId,
    final String title,
    final String? image,
    final Map<String, String> variant,
    final int qty,
    final double priceAtAdd,
  }) = _$OrderItemImpl;

  factory _OrderItem.fromJson(Map<String, dynamic> json) =
      _$OrderItemImpl.fromJson;

  @override
  String get productId;
  @override
  String get title;
  @override
  String? get image;
  @override
  Map<String, String> get variant;
  @override
  int get qty;
  @override
  double get priceAtAdd;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderTimelineEntry _$OrderTimelineEntryFromJson(Map<String, dynamic> json) {
  return _OrderTimelineEntry.fromJson(json);
}

/// @nodoc
mixin _$OrderTimelineEntry {
  String get status => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;

  /// Serializes this OrderTimelineEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderTimelineEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderTimelineEntryCopyWith<OrderTimelineEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderTimelineEntryCopyWith<$Res> {
  factory $OrderTimelineEntryCopyWith(
    OrderTimelineEntry value,
    $Res Function(OrderTimelineEntry) then,
  ) = _$OrderTimelineEntryCopyWithImpl<$Res, OrderTimelineEntry>;
  @useResult
  $Res call({String status, DateTime? date});
}

/// @nodoc
class _$OrderTimelineEntryCopyWithImpl<$Res, $Val extends OrderTimelineEntry>
    implements $OrderTimelineEntryCopyWith<$Res> {
  _$OrderTimelineEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderTimelineEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? date = freezed}) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            date: freezed == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderTimelineEntryImplCopyWith<$Res>
    implements $OrderTimelineEntryCopyWith<$Res> {
  factory _$$OrderTimelineEntryImplCopyWith(
    _$OrderTimelineEntryImpl value,
    $Res Function(_$OrderTimelineEntryImpl) then,
  ) = __$$OrderTimelineEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, DateTime? date});
}

/// @nodoc
class __$$OrderTimelineEntryImplCopyWithImpl<$Res>
    extends _$OrderTimelineEntryCopyWithImpl<$Res, _$OrderTimelineEntryImpl>
    implements _$$OrderTimelineEntryImplCopyWith<$Res> {
  __$$OrderTimelineEntryImplCopyWithImpl(
    _$OrderTimelineEntryImpl _value,
    $Res Function(_$OrderTimelineEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderTimelineEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? date = freezed}) {
    return _then(
      _$OrderTimelineEntryImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        date: freezed == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderTimelineEntryImpl implements _OrderTimelineEntry {
  const _$OrderTimelineEntryImpl({required this.status, this.date});

  factory _$OrderTimelineEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderTimelineEntryImplFromJson(json);

  @override
  final String status;
  @override
  final DateTime? date;

  @override
  String toString() {
    return 'OrderTimelineEntry(status: $status, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderTimelineEntryImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, date);

  /// Create a copy of OrderTimelineEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderTimelineEntryImplCopyWith<_$OrderTimelineEntryImpl> get copyWith =>
      __$$OrderTimelineEntryImplCopyWithImpl<_$OrderTimelineEntryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderTimelineEntryImplToJson(this);
  }
}

abstract class _OrderTimelineEntry implements OrderTimelineEntry {
  const factory _OrderTimelineEntry({
    required final String status,
    final DateTime? date,
  }) = _$OrderTimelineEntryImpl;

  factory _OrderTimelineEntry.fromJson(Map<String, dynamic> json) =
      _$OrderTimelineEntryImpl.fromJson;

  @override
  String get status;
  @override
  DateTime? get date;

  /// Create a copy of OrderTimelineEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderTimelineEntryImplCopyWith<_$OrderTimelineEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  String get id => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  List<OrderItem> get items => throw _privateConstructorUsedError;
  String? get addressId => throw _privateConstructorUsedError;
  String get shippingMethod => throw _privateConstructorUsedError;
  String get paymentMethod => throw _privateConstructorUsedError;
  PromoResult? get promo => throw _privateConstructorUsedError;
  double get subtotal => throw _privateConstructorUsedError;
  double get discount => throw _privateConstructorUsedError;
  double get shipping => throw _privateConstructorUsedError;
  double get tax => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  List<OrderTimelineEntry> get timeline => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call({
    String id,
    String? userId,
    List<OrderItem> items,
    String? addressId,
    String shippingMethod,
    String paymentMethod,
    PromoResult? promo,
    double subtotal,
    double discount,
    double shipping,
    double tax,
    double total,
    String status,
    List<OrderTimelineEntry> timeline,
    DateTime? createdAt,
  });

  $PromoResultCopyWith<$Res>? get promo;
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? items = null,
    Object? addressId = freezed,
    Object? shippingMethod = null,
    Object? paymentMethod = null,
    Object? promo = freezed,
    Object? subtotal = null,
    Object? discount = null,
    Object? shipping = null,
    Object? tax = null,
    Object? total = null,
    Object? status = null,
    Object? timeline = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String?,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<OrderItem>,
            addressId: freezed == addressId
                ? _value.addressId
                : addressId // ignore: cast_nullable_to_non_nullable
                      as String?,
            shippingMethod: null == shippingMethod
                ? _value.shippingMethod
                : shippingMethod // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentMethod: null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as String,
            promo: freezed == promo
                ? _value.promo
                : promo // ignore: cast_nullable_to_non_nullable
                      as PromoResult?,
            subtotal: null == subtotal
                ? _value.subtotal
                : subtotal // ignore: cast_nullable_to_non_nullable
                      as double,
            discount: null == discount
                ? _value.discount
                : discount // ignore: cast_nullable_to_non_nullable
                      as double,
            shipping: null == shipping
                ? _value.shipping
                : shipping // ignore: cast_nullable_to_non_nullable
                      as double,
            tax: null == tax
                ? _value.tax
                : tax // ignore: cast_nullable_to_non_nullable
                      as double,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as double,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            timeline: null == timeline
                ? _value.timeline
                : timeline // ignore: cast_nullable_to_non_nullable
                      as List<OrderTimelineEntry>,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PromoResultCopyWith<$Res>? get promo {
    if (_value.promo == null) {
      return null;
    }

    return $PromoResultCopyWith<$Res>(_value.promo!, (value) {
      return _then(_value.copyWith(promo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
    _$OrderImpl value,
    $Res Function(_$OrderImpl) then,
  ) = __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? userId,
    List<OrderItem> items,
    String? addressId,
    String shippingMethod,
    String paymentMethod,
    PromoResult? promo,
    double subtotal,
    double discount,
    double shipping,
    double tax,
    double total,
    String status,
    List<OrderTimelineEntry> timeline,
    DateTime? createdAt,
  });

  @override
  $PromoResultCopyWith<$Res>? get promo;
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
    _$OrderImpl _value,
    $Res Function(_$OrderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? items = null,
    Object? addressId = freezed,
    Object? shippingMethod = null,
    Object? paymentMethod = null,
    Object? promo = freezed,
    Object? subtotal = null,
    Object? discount = null,
    Object? shipping = null,
    Object? tax = null,
    Object? total = null,
    Object? status = null,
    Object? timeline = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$OrderImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String?,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<OrderItem>,
        addressId: freezed == addressId
            ? _value.addressId
            : addressId // ignore: cast_nullable_to_non_nullable
                  as String?,
        shippingMethod: null == shippingMethod
            ? _value.shippingMethod
            : shippingMethod // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentMethod: null == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as String,
        promo: freezed == promo
            ? _value.promo
            : promo // ignore: cast_nullable_to_non_nullable
                  as PromoResult?,
        subtotal: null == subtotal
            ? _value.subtotal
            : subtotal // ignore: cast_nullable_to_non_nullable
                  as double,
        discount: null == discount
            ? _value.discount
            : discount // ignore: cast_nullable_to_non_nullable
                  as double,
        shipping: null == shipping
            ? _value.shipping
            : shipping // ignore: cast_nullable_to_non_nullable
                  as double,
        tax: null == tax
            ? _value.tax
            : tax // ignore: cast_nullable_to_non_nullable
                  as double,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        timeline: null == timeline
            ? _value._timeline
            : timeline // ignore: cast_nullable_to_non_nullable
                  as List<OrderTimelineEntry>,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderImpl implements _Order {
  const _$OrderImpl({
    required this.id,
    this.userId,
    final List<OrderItem> items = const <OrderItem>[],
    this.addressId,
    this.shippingMethod = 'standard',
    this.paymentMethod = 'card',
    this.promo,
    this.subtotal = 0,
    this.discount = 0,
    this.shipping = 0,
    this.tax = 0,
    this.total = 0,
    this.status = 'placed',
    final List<OrderTimelineEntry> timeline = const <OrderTimelineEntry>[],
    this.createdAt,
  }) : _items = items,
       _timeline = timeline;

  factory _$OrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderImplFromJson(json);

  @override
  final String id;
  @override
  final String? userId;
  final List<OrderItem> _items;
  @override
  @JsonKey()
  List<OrderItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final String? addressId;
  @override
  @JsonKey()
  final String shippingMethod;
  @override
  @JsonKey()
  final String paymentMethod;
  @override
  final PromoResult? promo;
  @override
  @JsonKey()
  final double subtotal;
  @override
  @JsonKey()
  final double discount;
  @override
  @JsonKey()
  final double shipping;
  @override
  @JsonKey()
  final double tax;
  @override
  @JsonKey()
  final double total;
  @override
  @JsonKey()
  final String status;
  final List<OrderTimelineEntry> _timeline;
  @override
  @JsonKey()
  List<OrderTimelineEntry> get timeline {
    if (_timeline is EqualUnmodifiableListView) return _timeline;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeline);
  }

  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Order(id: $id, userId: $userId, items: $items, addressId: $addressId, shippingMethod: $shippingMethod, paymentMethod: $paymentMethod, promo: $promo, subtotal: $subtotal, discount: $discount, shipping: $shipping, tax: $tax, total: $total, status: $status, timeline: $timeline, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.addressId, addressId) ||
                other.addressId == addressId) &&
            (identical(other.shippingMethod, shippingMethod) ||
                other.shippingMethod == shippingMethod) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.promo, promo) || other.promo == promo) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.shipping, shipping) ||
                other.shipping == shipping) &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._timeline, _timeline) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    const DeepCollectionEquality().hash(_items),
    addressId,
    shippingMethod,
    paymentMethod,
    promo,
    subtotal,
    discount,
    shipping,
    tax,
    total,
    status,
    const DeepCollectionEquality().hash(_timeline),
    createdAt,
  );

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderImplToJson(this);
  }
}

abstract class _Order implements Order {
  const factory _Order({
    required final String id,
    final String? userId,
    final List<OrderItem> items,
    final String? addressId,
    final String shippingMethod,
    final String paymentMethod,
    final PromoResult? promo,
    final double subtotal,
    final double discount,
    final double shipping,
    final double tax,
    final double total,
    final String status,
    final List<OrderTimelineEntry> timeline,
    final DateTime? createdAt,
  }) = _$OrderImpl;

  factory _Order.fromJson(Map<String, dynamic> json) = _$OrderImpl.fromJson;

  @override
  String get id;
  @override
  String? get userId;
  @override
  List<OrderItem> get items;
  @override
  String? get addressId;
  @override
  String get shippingMethod;
  @override
  String get paymentMethod;
  @override
  PromoResult? get promo;
  @override
  double get subtotal;
  @override
  double get discount;
  @override
  double get shipping;
  @override
  double get tax;
  @override
  double get total;
  @override
  String get status;
  @override
  List<OrderTimelineEntry> get timeline;
  @override
  DateTime? get createdAt;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

import '../../core/network/api_guard.dart';
import '../api/kartly_api.dart';
import '../models/address.dart';

class AddressRepository {
  AddressRepository(this._api);

  final KartlyApi _api;

  Future<List<Address>> fetch() => guard(() => _api.getAddresses());

  Future<Address> create(Map<String, dynamic> body) =>
      guard(() => _api.createAddress(body));

  Future<Address> update(String id, Map<String, dynamic> body) =>
      guard(() => _api.updateAddress(id, body));

  Future<void> delete(String id) => guard(() => _api.deleteAddress(id));
}

import '../../core/network/api_guard.dart';
import '../api/kartly_api.dart';
import '../models/notification.dart';

class NotificationRepository {
  NotificationRepository(this._api);

  final KartlyApi _api;

  Future<List<AppNotification>> fetch() => guard(() => _api.getNotifications());
}

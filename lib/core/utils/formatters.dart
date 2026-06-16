import 'package:intl/intl.dart';

/// Currency and date formatting helpers. Never format money/dates inline —
/// always route through these so the app stays locale-correct.
class Formatters {
  const Formatters._();

  static final Map<String, NumberFormat> _currencyCache = {};

  static String currency(num amount, {String currencyCode = 'USD'}) {
    final format = _currencyCache.putIfAbsent(
      currencyCode,
      () => NumberFormat.simpleCurrency(name: currencyCode),
    );
    return format.format(amount);
  }

  static String date(DateTime date) => DateFormat.yMMMd().format(date);

  static String dateTime(DateTime date) => DateFormat.yMMMd().add_jm().format(date);

  /// Parses an ISO-8601 string defensively, returning the epoch on failure.
  static DateTime parseDate(String? iso) =>
      DateTime.tryParse(iso ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0);
}

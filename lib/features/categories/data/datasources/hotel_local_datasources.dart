import 'package:shared_preferences/shared_preferences.dart';

class HotelLocalDatasource {
  Future<Map<String, bool>> loadReviewStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    return {for (var key in keys) key: prefs.getBool(key) ?? false};
  }

  Future<void> markHotelAsReviewed(String hotelId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(hotelId, true);
  }
}

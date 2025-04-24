import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/booking_model.dart';

class RemoteBookingDatasources {
  static const String baseUrl =
      'https://e-commerce-d13dc-default-rtdb.firebaseio.com/';

  static Future<bool> createBooking(BookingModel booking, String userId) async {
    try {
      final url = Uri.parse('$baseUrl/hotel/users/$userId/bookings.json');

      final response = await http.post(url, body: jsonEncode(booking.toJson()));

      return response.statusCode == 200;
    } catch (e) {
      print('Bookingda xatolik: $e');
      rethrow;
    }
  }

  // Future<void> getBookings(String userId) async {
  //   try {
  //     List<BookingModel> bookings = [];

  //     final url = Uri.parse("$baseUrl/hotel/users/$userId/bookings.json");

  //     final response = await http.get(url);

  //     final decodedData = jsonDecode(response.body);

  //     decodedData
  //   } catch (e) {
  //     print("Get bo'lganda xatolik: $e");
  //   }
  // }

  static Future<List<BookingModel>> getBookings(String userId) async {
  try {
    final url = Uri.parse(
      '$baseUrl/hotel/users/$userId/bookings.json',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body) as Map<String, dynamic>?;

      if (decodedData == null) return [];

      return decodedData.entries.map((entry) {
        final bookingData = entry.value as Map<String, dynamic>;
        return BookingModel.fromJson(bookingData);
      }).toList();
    } else {
      throw Exception('Xatolik: ${response.statusCode}');
    }
  } catch (e) {
    print('Bookinglarni olishda xatolik: $e');
    rethrow;
  }
}

}

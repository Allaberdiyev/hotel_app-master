import 'dart:convert';
import 'package:hotel_app/features/search/data/models/hotel_model.dart';
import 'package:http/http.dart' as http;

class HotelRemoteDatasource {
  List<HotelModel> _hotels = [];

  Future<List<HotelModel>> fetchHotels() async {
    final url = Uri.parse(
      'https://e-commerce-d13dc-default-rtdb.firebaseio.com/hotel/admin/hotels.json',
    );
    final response = await http.get(url);
    final data = json.decode(response.body) as Map<String, dynamic>;

    _hotels =
        data.entries.map((entry) {
          final hotelId = entry.key;
          final hotelData = entry.value;
          return HotelModel.fromJson(json: hotelData, id: hotelId);
        }).toList();

    return _hotels;
  }

  List<HotelModel> getAllHotels() {
    return _hotels;
  }

  HotelModel getHotel(int index) {
    return _hotels[index];
  }

  Future<void> addReview(String hotelId, String comment, double rating) async {
    final reviewUrl = Uri.parse(
      "https://e-commerce-d13dc-default-rtdb.firebaseio.com/hotel/admin/hotels/$hotelId/review.json",
    );

    await http.post(
      reviewUrl,
      body: json.encode({"comment": comment, "rating": rating}),
    );

    final allReviewsUrl = Uri.parse(
      "https://e-commerce-d13dc-default-rtdb.firebaseio.com/hotel/admin/hotels/$hotelId/review.json",
    );

    final response = await http.get(allReviewsUrl);
    final data = json.decode(response.body) as Map<String, dynamic>?;

    if (data != null) {
      num totalRating = 0;
      double count = 0;

      data.forEach((key, value) {
        totalRating += value['rating'];
        count++;
      });

      final averageRating = count == 0 ? 0 : totalRating / count;

      final ratingUrl = Uri.parse(
        "https://e-commerce-d13dc-default-rtdb.firebaseio.com/hotel/admin/hotels/$hotelId/rating.json",
      );

      await http.put(ratingUrl, body: json.encode(averageRating));
    }
  }
}

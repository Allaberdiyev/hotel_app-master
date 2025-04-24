import 'package:dio/dio.dart';
import 'package:hotel_app/features/search/data/models/hotel_model.dart';

class SearchRemoteDatasource {
  late final Dio dio = Dio(
    BaseOptions(
      baseUrl:
          "https://e-commerce-d13dc-default-rtdb.firebaseio.com/hotel/admin/hotels",
    ),
  );
  Future<List<HotelModel>> fetchHotelData() async {
    List<HotelModel> hotels = [];

    try {
      Response response = await dio.get(".json");
      if (response.statusCode != 200) {
        throw Exception("Response: ${response.statusCode}");
      }
      final Map<String, dynamic> data = response.data;

      data.forEach((key, value) {
        hotels.add(HotelModel.fromJson(json: value));
        // print("1111111111${hotels}");
      });
    } catch (e, c) {
      print("$e     $c");
    }

    return hotels;
  }
}
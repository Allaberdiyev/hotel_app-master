import 'package:flutter/foundation.dart';
import 'package:hotel_app/features/categories/data/datasources/hotel_categories_datasources.dart';
import 'package:hotel_app/features/categories/data/datasources/hotel_local_datasources.dart';
import 'package:hotel_app/features/search/data/models/hotel_model.dart';

class HotelViewModel extends ChangeNotifier {
  final HotelRemoteDatasource remoteDatasource;
  final HotelLocalDatasource localDatasource;

  HotelViewModel({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  List<HotelModel> _hotels = [];
  Map<String, bool> _reviewedHotels = {};

  List<HotelModel> get hotels => _hotels;
  Map<String, bool> get reviewedHotels => _reviewedHotels;

  Future<void> loadHotels() async {
    _hotels = await remoteDatasource.fetchHotels();
    _reviewedHotels = await localDatasource.loadReviewStatus();
    notifyListeners();
  }

  HotelModel getHotel(int index) => _hotels[index];

  Future<void> addReview(String hotelId, String comment, double rating) async {
    await remoteDatasource.addReview(hotelId, comment, rating);
    await localDatasource.markHotelAsReviewed(hotelId);
    _reviewedHotels[hotelId] = true;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:hotel_app/features/search/data/datasources/search_remote_datasources.dart';
import 'package:hotel_app/features/search/data/models/hotel_model.dart';

class SearchViewmodel with ChangeNotifier {
  SearchViewmodel() {
    fetchData();
  }
  final SearchRemoteDatasource dataSource = SearchRemoteDatasource();
  List<HotelModel> hotels = [];

  bool isLoading = false;

  Future<void> fetchData() async {
    isLoading = true;
    notifyListeners();

    hotels = await dataSource.fetchHotelData();

    isLoading = false;
    notifyListeners();
  }
}

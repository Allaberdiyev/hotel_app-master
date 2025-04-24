import 'package:flutter/material.dart';

class FilterViewmodel extends ChangeNotifier {
  FilterViewmodel._konstruktor();
  static final FilterViewmodel _object = FilterViewmodel._konstruktor();
  factory FilterViewmodel() {
    return _object;
  }

  // double minPrice = 0;
  // double maxPrice = 0;

  double selectRating = 0;

  bool wf = false;
  bool tv = false;
  bool basseyn = false;
  bool breakfast = false;

  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();


  void wfSelected() {
    wf = !wf;
    notifyListeners();
  }

  void tvSelected() {
    tv = !tv;
    notifyListeners();
  }

  void basseynSelected() {
    basseyn = !basseyn;
    notifyListeners();
  }

  void breakfastSelected() {
    breakfast = !breakfast;
    notifyListeners();
  }

  void setSelectRating(double newRating) {
    if (selectRating == newRating) {
      selectRating = 0;
    } else {
      selectRating = newRating;
    }
    notifyListeners();
  }

  void clearPrice() {
    minController.clear();
    maxController.clear();
    notifyListeners();
  }

  void applyPriceFilter() {
    notifyListeners();
  }
}
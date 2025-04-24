import 'package:hotel_app/features/categories/data/models/review_model.dart';

class HotelModel {
  String? id;
  final String name;
  final String address;
  final String description;
  final List<String> facilities;
  final List<String> image;
  final int price;
  double rating;
  final List<String> type;
  final List<ReviewModel> reviews;

  HotelModel({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.facilities,
    required this.image,
    required this.price,
    required this.rating,
    required this.type,
    required this.reviews,
  });

  factory HotelModel.fromJson({
    required Map<String, dynamic> json,
    String? id,
  }) {
    return HotelModel(
      id: id,
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      facilities: (json['facilities'] as List?)?.cast<String>() ?? [],
      image: (json['image'] as List?)?.cast<String>() ?? [],
      price: json['price'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      type: (json['type'] as List?)?.cast<String>() ?? [],
      reviews:
          (json['review'] as Map<String, dynamic>?)?.values
              .map((e) => ReviewModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

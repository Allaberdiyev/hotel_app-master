class BookingModel {
  final String hotelName;
  final String type;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> facilities;
  final List<String> images;
  final String description;
  final int totalPrice;

  BookingModel({
    required this.hotelName,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.facilities,
    required this.images,
    required this.description,
    required this.totalPrice,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      hotelName: json['name'] ?? '',
      type: json['type'] ?? '',
      startDate: DateTime.parse(json["startDate"]),
      endDate: DateTime.parse(json["endDate"]),

      facilities: List<String>.from(json['facilities'] ?? []),
      images: List<String>.from(json['images'] ?? []),
      description: json['description'] ?? '',
      totalPrice: json['totalPrice'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': hotelName,
      'type': type,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'facilities': facilities,
      'images': images,
      'description': description,
      'totalPrice': totalPrice,
    };
  }
}

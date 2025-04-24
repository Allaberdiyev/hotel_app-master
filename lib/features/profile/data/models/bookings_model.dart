class BookingsModel {
  final String description;
  final String endDate;
  final List<String> facilities;
  final List<String> images;
  final String name;
  final String startDate;
  final int totalPrice;
  final String type;

  BookingsModel({
    required this.name,
    required this.endDate,
    required this.description,
    required this.images,
    required this.startDate,
    required this.facilities,
    required this.totalPrice,
    required this.type,
  });

  factory BookingsModel.fromMap(Map<String, dynamic> map) {
    return BookingsModel(
      description: map['description'] ?? '',
      endDate: map['endDate'] ?? '',
      facilities: List<String>.from(map['facilities'] ?? []),
      images: List<String>.from(map['images'] ?? []),
      name: map['name'] ?? '',
      startDate: map['startDate'] ?? '',
      totalPrice: map['totalPrice'] ?? 0,
      type: map['type'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'endDate': endDate,
      'facilities': facilities,
      'images': images,
      'name': name,
      'startDate': startDate,
      'totalPrice': totalPrice,
      'type': type,
    };
  }
}

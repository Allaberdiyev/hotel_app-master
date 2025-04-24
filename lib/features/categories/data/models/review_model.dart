class ReviewModel {
  final String comment;
  final double rating;

  ReviewModel({required this.comment, required this.rating});

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      comment: json['comment'],
      rating: (json['rating'] as num).toDouble(),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'rating': rating,
    };
  }

  ReviewModel copyWith({
    String? comment,
    double? rating,
  }) {
    return ReviewModel(
      comment: comment ?? this.comment,
      rating: rating ?? this.rating,
    );
  }
}

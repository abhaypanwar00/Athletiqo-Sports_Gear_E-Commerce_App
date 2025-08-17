class RatingModel {
  final double averageRating;
  final int ratingCount;

  RatingModel({
    this.averageRating = 0.0,
    this.ratingCount = 0,
  });

  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      averageRating: (map['averageRating'] ?? 0.0).toDouble(),
      ratingCount: map['ratingCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'averageRating': averageRating,
      'ratingCount': ratingCount,
    };
  }
}
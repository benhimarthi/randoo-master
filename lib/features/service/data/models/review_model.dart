import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/service/domain/entities/review.dart';

class ReviewModel extends Review {
  const ReviewModel({
    required super.id,
    required super.serviceId,
    required super.userId,
    required super.rating,
    required super.comment,
    required super.createdAt,
  });

  factory ReviewModel.fromMap(DataMap map) {
    return ReviewModel(
      id: map['id'] as String,
      serviceId: map['serviceId'] as String,
      userId: map['userId'] as String,
      rating: (map['rating'] as num).toDouble(),
      comment: map['comment'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  factory ReviewModel.fromEntity(Review entity) {
    return ReviewModel(
      id: entity.id,
      serviceId: entity.serviceId,
      userId: entity.userId,
      rating: entity.rating,
      comment: entity.comment,
      createdAt: entity.createdAt,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'serviceId': serviceId,
      'userId': userId,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

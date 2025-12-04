
import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/service/domain/entities/review.dart';

class ReviewModel extends Review {
  const ReviewModel({
    required super.id,
    required super.serviceId,
    required super.userId,
    required super.comment,
    required super.rating,
    required super.createdAt,
  });

  factory ReviewModel.fromMap(DataMap map) {
    return ReviewModel(
      id: map['id'] as String,
      serviceId: map['serviceId'] as String,
      userId: map['userId'] as String,
      comment: map['comment'] as String,
      rating: (map['rating'] as num).toDouble(),
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'serviceId': serviceId,
      'userId': userId,
      'comment': comment,
      'rating': rating,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

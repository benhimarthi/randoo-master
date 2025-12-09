import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String id;
  final String serviceId;
  final String userId;
  final String comment;
  final double rating;
  final DateTime createdAt;

  const Review({
    required this.id,
    required this.serviceId,
    required this.userId,
    required this.comment,
    required this.rating,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, serviceId, userId];
}

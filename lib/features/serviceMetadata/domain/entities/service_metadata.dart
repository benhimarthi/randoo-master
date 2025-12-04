import 'package:equatable/equatable.dart';

class ServiceMetadata extends Equatable {
  const ServiceMetadata({
    required this.serviceId,
    required this.clicks,
    required this.reviewsCount,
    required this.totalRating,
  });

  final String serviceId;
  final int clicks;
  final int reviewsCount;
  final int totalRating;

  double get averageRating => reviewsCount > 0 ? totalRating / reviewsCount : 0.0;

  @override
  List<Object?> get props => [serviceId, clicks, reviewsCount, totalRating];
}

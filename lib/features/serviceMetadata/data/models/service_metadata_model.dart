import 'package:myapp/features/serviceMetadata/domain/entities/service_metadata.dart';

class ServiceMetadataModel extends ServiceMetadata {
  const ServiceMetadataModel({
    required super.serviceId,
    required super.clicks,
    required super.reviewsCount,
    required super.totalRating,
  });

  factory ServiceMetadataModel.fromMap(Map<String, dynamic> map) {
    return ServiceMetadataModel(
      serviceId: map['serviceId'],
      clicks: map['clicks'],
      reviewsCount: map['reviewsCount'],
      totalRating: map['totalRating'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'serviceId': serviceId,
      'clicks': clicks,
      'reviewsCount': reviewsCount,
      'totalRating': totalRating,
    };
  }
}

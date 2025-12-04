part of 'service_metadata_bloc.dart';

abstract class ServiceMetadataEvent extends Equatable {
  const ServiceMetadataEvent();

  @override
  List<Object> get props => [];
}

class GetServiceMetadataEvent extends ServiceMetadataEvent {
  final String serviceId;

  const GetServiceMetadataEvent(this.serviceId);

  @override
  List<Object> get props => [serviceId];
}

class GetAllServiceMetadataEvent extends ServiceMetadataEvent {
  const GetAllServiceMetadataEvent();
}

class IncrementServiceClicksEvent extends ServiceMetadataEvent {
  final String serviceId;

  const IncrementServiceClicksEvent(this.serviceId);

  @override
  List<Object> get props => [serviceId];
}

class UpdateServiceReviewEvent extends ServiceMetadataEvent {
  final String serviceId;
  final int rating;

  const UpdateServiceReviewEvent({
    required this.serviceId,
    required this.rating,
  });

  @override
  List<Object> get props => [serviceId, rating];
}

part of 'service_cubit.dart';

abstract class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object> get props => [];
}

class ServiceInitial extends ServiceState {}

class CreatingService extends ServiceState {}

class ServiceCreated extends ServiceState {}

class GettingServices extends ServiceState {}

class ServicesLoaded extends ServiceState {
  final List<Service> services;

  const ServicesLoaded(this.services);

  @override
  List<Object> get props => [services];
}

class ServiceLoaded extends ServiceState {
  final Service service;

  const ServiceLoaded(this.service);

  @override
  List<Object> get props => [service];
}

class UpdatingService extends ServiceState {}

class ServiceUpdated extends ServiceState {}

class DeletingService extends ServiceState {}

class ServiceDeleted extends ServiceState {}

class ReviewsLoaded extends ServiceState {
  final List<Review> reviews;

  const ReviewsLoaded(this.reviews);

  @override
  List<Object> get props => [reviews];
}

class ReviewedServicesLoaded extends ServiceState {
  final List<Service> services;

  const ReviewedServicesLoaded(this.services);

  @override
  List<Object> get props => [services];
}

class ServiceError extends ServiceState {
  final String message;

  const ServiceError(this.message);

  @override
  List<Object> get props => [message];
}

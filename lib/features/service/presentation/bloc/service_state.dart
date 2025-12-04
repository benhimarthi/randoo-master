part of 'service_bloc.dart';

abstract class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object> get props => [];
}

class ServiceInitial extends ServiceState {}

class CreatingService extends ServiceState {}

class GettingServices extends ServiceState {}

class UpdatingService extends ServiceState {}

class DeletingService extends ServiceState {}

class AddingReview extends ServiceState {}

class GettingReviews extends ServiceState {}

class ServiceCreated extends ServiceState {}

class ServicesLoaded extends ServiceState {
  final List<Service> services;

  const ServicesLoaded(this.services);

  @override
  List<Object> get props => [services];
}

class ServiceUpdated extends ServiceState {}

class ServiceDeleted extends ServiceState {}

class ReviewAdded extends ServiceState {}

class ReviewsLoaded extends ServiceState {
  final List<Review> reviews;

  const ReviewsLoaded(this.reviews);

  @override
  List<Object> get props => [reviews];
}

class ServiceError extends ServiceState {
  final String message;

  const ServiceError(this.message);

  @override
  List<Object> get props => [message];
}

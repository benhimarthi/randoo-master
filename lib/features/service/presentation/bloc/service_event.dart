part of 'service_bloc.dart';

abstract class ServiceEvent extends Equatable {
  const ServiceEvent();

  @override
  List<Object> get props => [];
}

class CreateServiceEvent extends ServiceEvent {
  final Service service;

  const CreateServiceEvent(this.service);

  @override
  List<Object> get props => [service];
}

class GetServicesEvent extends ServiceEvent {
  const GetServicesEvent();
}

class UpdateServiceEvent extends ServiceEvent {
  final Service service;

  const UpdateServiceEvent(this.service);

  @override
  List<Object> get props => [service];
}

class DeleteServiceEvent extends ServiceEvent {
  final String serviceId;

  const DeleteServiceEvent(this.serviceId);

  @override
  List<Object> get props => [serviceId];
}

class AddReviewEvent extends ServiceEvent {
  final Review review;

  const AddReviewEvent(this.review);

  @override
  List<Object> get props => [review];
}

class GetReviewsEvent extends ServiceEvent {
  final String serviceId;

  const GetReviewsEvent(this.serviceId);

  @override
  List<Object> get props => [serviceId];
}

part of 'service_metadata_bloc.dart';

abstract class ServiceMetadataState extends Equatable {
  const ServiceMetadataState();

  @override
  List<Object> get props => [];
}

class ServiceMetadataInitial extends ServiceMetadataState {}

class ServiceMetadataLoading extends ServiceMetadataState {}

class ServiceMetadataLoaded extends ServiceMetadataState {
  final ServiceMetadata metadata;

  const ServiceMetadataLoaded(this.metadata);

  @override
  List<Object> get props => [metadata];
}

class AllServiceMetadataLoaded extends ServiceMetadataState {
  final List<ServiceMetadata> metadata;

  const AllServiceMetadataLoaded(this.metadata);

  @override
  List<Object> get props => [metadata];
}

class ServiceMetadataError extends ServiceMetadataState {
  final String message;

  const ServiceMetadataError(this.message);

  @override
  List<Object> get props => [message];
}

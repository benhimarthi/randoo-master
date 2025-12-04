import 'package:equatable/equatable.dart';
import 'package:myapp/core/usecases/usecase.dart';
import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/serviceMetadata/domain/repositories/service_metadata_repository.dart';

class UpdateServiceReview extends UseCaseWithParam<void, UpdateServiceReviewParams> {
  final ServiceMetadataRepository repository;

  UpdateServiceReview(this.repository);

  @override
  ResultVoid call(UpdateServiceReviewParams params) =>
      repository.updateServiceReview(serviceId: params.serviceId, rating: params.rating);
}

class UpdateServiceReviewParams extends Equatable {
  final String serviceId;
  final int rating;

  const UpdateServiceReviewParams({required this.serviceId, required this.rating});

  @override
  List<Object?> get props => [serviceId, rating];
}

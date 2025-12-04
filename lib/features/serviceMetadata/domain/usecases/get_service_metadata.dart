import 'package:myapp/core/usecases/usecase.dart';
import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/serviceMetadata/domain/entities/service_metadata.dart';
import 'package:myapp/features/serviceMetadata/domain/repositories/service_metadata_repository.dart';

class GetServiceMetadata extends UseCaseWithParam<ServiceMetadata, String> {
  final ServiceMetadataRepository repository;

  GetServiceMetadata(this.repository);

  @override
  ResultFuture<ServiceMetadata> call(String params) {
    return repository.getServiceMetadata(params);
  }
}

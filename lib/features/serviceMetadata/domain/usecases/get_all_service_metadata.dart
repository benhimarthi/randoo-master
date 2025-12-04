import 'package:myapp/core/usecases/usecase.dart';
import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/serviceMetadata/domain/entities/service_metadata.dart';
import 'package:myapp/features/serviceMetadata/domain/repositories/service_metadata_repository.dart';

class GetAllServiceMetadata implements UseCaseWithoutParam<List<ServiceMetadata>> {
  final ServiceMetadataRepository repository;

  GetAllServiceMetadata(this.repository);

  @override
  ResultFuture<List<ServiceMetadata>> call() {
    return repository.getAllServiceMetadata();
  }
}

import 'package:equatable/equatable.dart';
import 'package:myapp/core/usecases/usecase.dart';
import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/serviceMetadata/domain/repositories/service_metadata_repository.dart';

class IncrementServiceClicks extends UseCaseWithParam<void, String> {
  final ServiceMetadataRepository repository;

  IncrementServiceClicks(this.repository);

  @override
  ResultVoid call(String params) => repository.incrementServiceClicks(params);
}

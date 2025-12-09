import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/service/domain/entities/service.dart';
import 'package:myapp/features/service/domain/repositories/service_repository.dart';

import '../../../../core/usecases/usecase.dart';

class CreateService implements UseCaseWithParam<void, Service> {
  final ServiceRepository _repository;

  CreateService(this._repository);

  @override
  ResultFuture<void> call(Service params) {
    return _repository.createService(params);
  }
}

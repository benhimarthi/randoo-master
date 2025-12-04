import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/service/domain/entities/service.dart';
import 'package:myapp/features/service/domain/repositories/service_repository.dart';
import '../../../../core/usecases/usecase.dart';

class UpdateService extends UseCaseWithParam<void, Service> {
  final ServiceRepository _repository;

  UpdateService(this._repository);

  @override
  ResultFuture<void> call(Service params) async {
    return await _repository.updateService(params);
  }
}

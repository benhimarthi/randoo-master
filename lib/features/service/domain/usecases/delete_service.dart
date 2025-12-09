import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/service/domain/repositories/service_repository.dart';

import '../../../../core/usecases/usecase.dart';

class DeleteService extends UseCaseWithParam<void, String> {
  final ServiceRepository _repository;

  DeleteService(this._repository);

  @override
  ResultFuture<void> call(String params) async {
    return await _repository.deleteService(params);
  }
}

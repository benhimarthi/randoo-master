import 'package:myapp/core/usecases/usecase.dart';
import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/service/domain/entities/service.dart';
import 'package:myapp/features/service/domain/repositories/service_repository.dart';

class GetServices extends UseCaseWithoutParam<List<Service>> {
  final ServiceRepository _repository;

  GetServices(this._repository);

  @override
  ResultFuture<List<Service>> call() {
    return _repository.getServices();
  }
}

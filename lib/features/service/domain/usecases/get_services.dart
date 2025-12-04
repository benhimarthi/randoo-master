import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/service/domain/entities/service.dart';
import 'package:myapp/features/service/domain/repositories/service_repository.dart';
import '../../../../core/usecases/usecase.dart';

class GetServices implements UseCaseWithoutParam<List<Service>> {
  final ServiceRepository _repository;

  GetServices(this._repository);

  @override
  ResultFuture<List<Service>> call() {
    return _repository.getServices();
  }
}

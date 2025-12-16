import 'package:myapp/core/usecases/usecase.dart';

import '../../../../core/utils/typedef.dart';
import '../entities/service.dart';
import '../repositories/service_repository.dart';

class GetServiceById extends UseCaseWithParam<Service, String> {
  final ServiceRepository repository;

  GetServiceById(this.repository);

  @override
  ResultFuture<Service> call(String params) {
    return repository.getServiceById(params);
  }
}

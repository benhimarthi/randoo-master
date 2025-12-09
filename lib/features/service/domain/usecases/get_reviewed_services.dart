import 'package:myapp/core/usecases/usecase.dart';
import 'package:myapp/features/service/domain/entities/service.dart';
import 'package:myapp/features/service/domain/repositories/service_repository.dart';

import '../../../../core/utils/typedef.dart';

class GetReviewedServices implements UseCaseWithParam<List<Service>, String> {
  final ServiceRepository repository;

  GetReviewedServices(this.repository);

  @override
  ResultFuture<List<Service>> call(String params) {
    return repository.getReviewedServices(params);
  }
}

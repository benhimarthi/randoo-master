
import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/service/domain/entities/review.dart';
import 'package:myapp/features/service/domain/repositories/service_repository.dart';
import '../../../../core/usecases/usecase.dart';

class GetReviews implements UseCaseWithParam<List<Review>, String> {
  final ServiceRepository _repository;

  GetReviews(this._repository);

  @override
  ResultFuture<List<Review>> call(String params) {
    return _repository.getReviews(params);
  }
}

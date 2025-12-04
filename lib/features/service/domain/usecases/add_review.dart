import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/service/domain/entities/review.dart';
import 'package:myapp/features/service/domain/repositories/service_repository.dart';
import '../../../../core/usecases/usecase.dart';

class AddReview implements UseCaseWithParam<void, Review> {
  final ServiceRepository _repository;

  AddReview(this._repository);

  @override
  ResultFuture<void> call(Review params) {
    return _repository.addReview(params);
  }
}

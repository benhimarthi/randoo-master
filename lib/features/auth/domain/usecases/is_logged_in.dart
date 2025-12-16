import 'package:myapp/core/usecases/usecase.dart';
import 'package:myapp/core/utils/typedef.dart';

import '../repositories/auth_repo.dart';

class IsLoggedIn extends UseCaseWithoutParam<bool> {
  final AuthRepo repository;

  IsLoggedIn(this.repository);

  @override
  ResultFuture<bool> call() {
    return repository.isLoggedIn();
  }
}

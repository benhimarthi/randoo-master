import 'package:myapp/core/usecases/usecase.dart';
import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/auth/domain/entities/user.dart';

import '../repositories/auth_repo.dart';

class IsLoggedIn extends UseCaseWithoutParam<User?> {
  final AuthRepo repository;

  IsLoggedIn(this.repository);

  @override
  ResultFuture<User?> call() {
    return repository.isLoggedIn();
  }
}

import 'package:myapp/core/usecases/usecase.dart';
import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/auth/domain/repositories/auth_repo.dart';

class SignOut extends UseCaseWithoutParam<void> {
  final AuthRepo _repository;

  SignOut(this._repository);

  @override
  ResultFuture<void> call() async {
    return await _repository.signOut();
  }
}

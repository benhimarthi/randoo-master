import 'package:myapp/core/usecases/usecase.dart';
import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/auth/domain/entities/user.dart';
import 'package:myapp/features/auth/domain/repositories/auth_repo.dart';

class SignIn extends UseCaseWithParam<User, SignInParams> {
  final AuthRepo _repo;

  const SignIn(this._repo);

  @override
  ResultFuture<User> call(SignInParams params) async =>
      _repo.signIn(params.email, params.password);
}

class SignInParams {
  final String email;
  final String password;

  const SignInParams({required this.email, required this.password});
}

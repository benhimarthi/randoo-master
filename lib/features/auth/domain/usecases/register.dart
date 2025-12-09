import 'package:myapp/core/usecases/usecase.dart';
import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/auth/domain/entities/user.dart';
import 'package:myapp/features/auth/domain/repositories/auth_repo.dart';

class Register extends UseCaseWithParam<User, RegisterParams> {
  final AuthRepo _repo;

  const Register(this._repo);

  @override
  ResultFuture<User> call(RegisterParams params) async => _repo.register(
    params.name,
    params.email,
    params.password,
    params.userType,
  );
}

class RegisterParams {
  final String name;
  final String email;
  final String password;
  final String userType;

  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    required this.userType,
  });
}

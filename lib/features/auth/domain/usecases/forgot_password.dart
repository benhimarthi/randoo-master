
import 'package:myapp/core/usecases/usecase.dart';
import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/auth/domain/repositories/auth_repo.dart';

class ForgotPassword extends UseCaseWithParam<void, String> {
  final AuthRepo _repo;

  const ForgotPassword(this._repo);

  @override
  ResultVoid call(String params) async => _repo.forgotPassword(params);
}

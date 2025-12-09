import 'package:myapp/core/usecases/usecase.dart';
import 'package:myapp/core/utils/typedef.dart';
import '../repositories/auth_repo.dart';

class DeleteUser extends UseCaseWithParam<void, String> {
  final AuthRepo _repository;

  DeleteUser(this._repository);

  @override
  ResultFuture<void> call(String params) async {
    return await _repository.deleteUser(params);
  }
}

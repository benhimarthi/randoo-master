import 'package:myapp/core/usecases/usecase.dart';
import 'package:myapp/features/auth/domain/entities/user.dart';
import 'package:myapp/features/auth/domain/repositories/auth_repo.dart';
import '../../../../core/utils/typedef.dart';

class UpdateUser extends UseCaseWithParam<User, UpdateUserParams> {
  const UpdateUser(this._repo);
  final AuthRepo _repo;
  @override
  ResultFuture<User> call(UpdateUserParams params) => _repo.updateUser(params);
}

class UpdateUserParams {
  const UpdateUserParams({
    required this.id,
    required this.name,
    required this.email,
    required this.userType,
  });

  final String id;
  final String name;
  final String email;
  final String userType;
}

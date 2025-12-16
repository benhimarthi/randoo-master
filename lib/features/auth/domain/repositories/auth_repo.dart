import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/auth/domain/entities/user.dart';

import '../usecases/update_user.dart';

abstract class AuthRepo {
  const AuthRepo();
  ResultFuture<User> signIn(String email, String password);
  ResultFuture<bool> isLoggedIn();
  ResultFuture<User> register(
    String name,
    String email,
    String password,
    String userType,
  );
  ResultVoid deleteUser(String id);
  ResultVoid forgotPassword(String email);
  ResultVoid signOut();
  ResultFuture<User> updateUser(UpdateUserParams params);
}

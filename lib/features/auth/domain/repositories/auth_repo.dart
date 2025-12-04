
import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/auth/domain/entities/user.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultFuture<User> signIn(
    String email,
    String password,
  );

  ResultFuture<User> register(
    String name,
    String email,
    String password,
    String userType,
  );

  ResultVoid forgotPassword(String email);

  ResultVoid signOut();
}

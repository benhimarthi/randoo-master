
import 'package:myapp/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<UserModel> signIn(
    String email,
    String password,
  );

  Future<UserModel> register(
    String name,
    String email,
    String password,
    String userType,
  );

  Future<void> forgotPassword(String email);

  Future<void> signOut();
}

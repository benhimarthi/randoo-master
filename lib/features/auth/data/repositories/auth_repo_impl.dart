import 'package:dartz/dartz.dart';
import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:myapp/features/auth/domain/entities/user.dart';
import 'package:myapp/features/auth/domain/repositories/auth_repo.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/firebase_failure.dart';
import '../../domain/usecases/update_user.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  const AuthRepoImpl(this._remoteDataSource, this._localDataSource);

  @override
  ResultFuture<User> signIn(String email, String password) async {
    try {
      final user = await _remoteDataSource.signIn(email, password);
      final token = user.id;
      await _localDataSource.saveToken(token);
      return Right(user);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<bool> isLoggedIn() async {
    try {
      final token = await _localDataSource.getToken();
      return Right(token != null);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<User> register(
    String name,
    String email,
    String password,
    String userType,
  ) async {
    try {
      final user = await _remoteDataSource.register(
        name,
        email,
        password,
        userType,
      );
      return Right(user);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
      return const Right(null);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteUser(String id) async {
    try {
      await _remoteDataSource.deleteUser(id);
      await _localDataSource.clearToken();
      return const Right(null);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid signOut() async {
    try {
      await _remoteDataSource.signOut();
      await _localDataSource.clearToken();
      return const Right(null);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<User> updateUser(UpdateUserParams params) async {
    try {
      final user = await _remoteDataSource.updateUser(params);
      return Right(user);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/core/errors/exceptions.dart';
import 'package:myapp/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:myapp/features/auth/data/models/user_model.dart';
import 'package:myapp/features/auth/domain/usecases/update_user.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  const AuthRemoteDataSourceImpl(this._auth, this._firestore);

  @override
  Future<UserModel> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw const FirebaseExceptions(
          message: 'User not found',
          statusCode: 404,
        );
      }

      final doc = await _firestore.collection('users').doc(user.uid).get();

      if (!doc.exists) {
        throw const FirebaseExceptions(
          message: 'User not found',
          statusCode: 404,
        );
      }

      return UserModel.fromMap(doc.data()!);
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptions(
        message: e.message ?? 'An error occurred',
        statusCode: 500,
      );
    } on FirebaseExceptions {
      rethrow;
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<UserModel> register(
    String name,
    String email,
    String password,
    String userType,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw const FirebaseExceptions(
          message: 'User not found',
          statusCode: 404,
        );
      }

      final userModel = UserModel(
        id: user.uid,
        name: name,
        email: email,
        profilePic: '',
        userType: userType,
        createdAt: DateTime.now(),
      );

      await _firestore.collection('users').doc(user.uid).set(userModel.toMap());

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptions(
        message: e.message ?? 'An error occurred',
        statusCode: 500,
      );
    } on FirebaseExceptions {
      rethrow;
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptions(
        message: e.message ?? 'An error occurred',
        statusCode: 500,
      );
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<UserModel> updateUser(UpdateUserParams params) async {
    try {
      await _firestore.collection('users').doc(params.id).update({
        'name': params.name,
        'email': params.email,
        'userType': params.userType,
      });

      final doc = await _firestore.collection('users').doc(params.id).get();

      return UserModel.fromMap(doc.data()!);
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptions(
        message: e.message ?? 'An error occurred',
        statusCode: 500,
      );
    } on FirebaseExceptions {
      rethrow;
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      await _auth.currentUser?.delete();
      await _firestore.collection('users').doc(id).delete();
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptions(
        message: e.message ?? 'An error occurred',
        statusCode: 500,
      );
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptions(
        message: e.message ?? 'An error occurred',
        statusCode: 500,
      );
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 500);
    }
  }
}

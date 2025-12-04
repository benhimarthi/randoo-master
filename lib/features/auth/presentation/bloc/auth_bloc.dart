
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/features/auth/domain/entities/user.dart';
import 'package:myapp/features/auth/domain/usecases/forgot_password.dart';
import 'package:myapp/features/auth/domain/usecases/register.dart';
import 'package:myapp/features/auth/domain/usecases/sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignIn _signIn;
  final Register _register;
  final ForgotPassword _forgotPassword;

  AuthBloc({
    required SignIn signIn,
    required Register register,
    required ForgotPassword forgotPassword,
  })  : _signIn = signIn,
        _register = register,
        _forgotPassword = forgotPassword,
        super(const AuthInitial()) {
    on<SignInEvent>(_signInHandler);
    on<RegisterEvent>(_registerHandler);
    on<ForgotPasswordEvent>(_forgotPasswordHandler);
  }

  Future<void> _signInHandler(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _signIn(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (user) => emit(SignedIn(user)),
    );
  }

  Future<void> _registerHandler(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _register(
      RegisterParams(
        name: event.name,
        email: event.email,
        password: event.password,
        userType: event.userType,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (user) => emit(Registered(user)),
    );
  }

  Future<void> _forgotPasswordHandler(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _forgotPassword(event.email);

    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (_) => emit(const ForgotPasswordSent()),
    );
  }
}

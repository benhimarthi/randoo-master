
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class SignedIn extends AuthState {
  final User user;

  const SignedIn(this.user);

  @override
  List<Object> get props => [user];
}

class Registered extends AuthState {
  final User user;

  const Registered(this.user);

  @override
  List<Object> get props => [user];
}

class ForgotPasswordSent extends AuthState {
  const ForgotPasswordSent();
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

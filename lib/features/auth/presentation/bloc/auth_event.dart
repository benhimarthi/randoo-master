
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String userType;

  const RegisterEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.userType,
  });

  @override
  List<Object> get props => [name, email, password, userType];
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  const ForgotPasswordEvent(this.email);

  @override
  List<Object> get props => [email];
}

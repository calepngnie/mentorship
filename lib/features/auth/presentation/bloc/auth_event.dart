part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phone;
  final String userType;
  final String module;

  const SignUpRequested({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.userType,
    required this.module,
  });

  @override
  List<Object> get props => [email, password, firstName, lastName, phone, userType, module];
}

class LinkedInSignInRequested extends AuthEvent {
  final String moduleType;

  const LinkedInSignInRequested({
    required this.moduleType,
  });

  @override
  List<Object> get props => [moduleType];
}

class LinkedInSignUpRequested extends AuthEvent {
  final String moduleType;
  final String userType;

  const LinkedInSignUpRequested({
    required this.moduleType,
    required this.userType,
  });

  @override
  List<Object> get props => [moduleType, userType];
}

class SignOutRequested extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

abstract class LoginState {}

abstract class LoginAction extends LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginAction {}

class LoginFailure extends LoginAction {
  final String message;

  LoginFailure({required this.message});
}

part of 'user_login_cubit.dart';

@immutable
abstract class UserLoginState {}

class UserLoginInitial extends UserLoginState {}

class UserLoginOnProcess extends UserLoginState {}

class UserLoginOnSucess extends UserLoginState {}

class UserLoginOnError extends UserLoginState {
  final String message;

  UserLoginOnError(this.message);
}

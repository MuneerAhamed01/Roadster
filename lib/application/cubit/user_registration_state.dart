part of 'user_registration_cubit.dart';

@immutable
abstract class UserRegistrationState {}

class UserRegistrationInitial extends UserRegistrationState {}

class UserRegistrationOnprosess extends UserRegistrationState {}

class UserRegistrationOnsuccess extends UserRegistrationState {}

class UserRegistrationOnError extends UserRegistrationState {
  final String message;

  UserRegistrationOnError(this.message);
}

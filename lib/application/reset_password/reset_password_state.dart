part of 'reset_password_cubit.dart';

@immutable
abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}
class ResetPasswordOnDone extends ResetPasswordState {}
class ResetPasswordOnprocess extends ResetPasswordState {}
class ResetPasswordOnError extends ResetPasswordState {}

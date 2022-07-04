part of 'otpcheaking_cubit.dart';

@immutable
abstract class OtpcheakingState {}

class OtpcheakingInitial extends OtpcheakingState {}

class OtpcheakingOnprocess extends OtpcheakingState {}

class OtpcheakingOnMobcheack extends OtpcheakingState {}

class OtpcheakMobError extends OtpcheakingState {
  final String message;

  OtpcheakMobError(this.message);
}

class OtpcheakingotpCheck extends OtpcheakingState {}

class OtpcheakingotpError extends OtpcheakingState {}

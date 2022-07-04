part of 'otpresendtimer_cubit.dart';

@immutable
abstract class OtpresendtimerState {}

class OtpresendtimerInitial extends OtpresendtimerState {}

class OtpresendtimerOncounting extends OtpresendtimerState {
 final int countValue;

  OtpresendtimerOncounting(this.countValue);
}

class OtpresendtimeroncountingFinished extends OtpresendtimerState {}

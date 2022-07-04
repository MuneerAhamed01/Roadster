import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'otpresendtimer_state.dart';

class OtpresendtimerCubit extends Cubit<OtpresendtimerState> {
  OtpresendtimerCubit() : super(OtpresendtimerInitial());
  Timer? timerbase;
  void timerCheack(int count) {
    if (count == 31) {
      timerbase = Timer.periodic(const Duration(seconds: 1), (timer) {
        count--;
        emit(OtpresendtimerOncounting(count));
        if (count == 0) {
          timer.cancel();
          emit(OtpresendtimeroncountingFinished());
        }
      });
    } else {
      timerbase!.cancel();
      
    }
  }
}

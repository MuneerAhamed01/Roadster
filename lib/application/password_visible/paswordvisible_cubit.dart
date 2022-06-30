import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'paswordvisible_state.dart';

class PaswordvisibleCubit extends Cubit<PaswordvisibleState> {
  PaswordvisibleCubit() : super(PaswordvisibleInitial(true));
  void onPressed(bool visible) {
    visible = !visible;
    emit(PaswordvisibleInitial(visible));
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottomnavigation_state.dart';

class BottomnavigationCubit extends Cubit<BottomnavigationState> {
  BottomnavigationCubit() : super(BottomnavigationChanging(0));
  void onChangingIndex(int index) {
    emit(BottomnavigationChanging(index));
  }
}

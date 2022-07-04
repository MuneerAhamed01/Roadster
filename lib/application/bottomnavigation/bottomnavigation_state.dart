part of 'bottomnavigation_cubit.dart';

@immutable
abstract class BottomnavigationState {}

class BottomnavigationChanging extends BottomnavigationState {
  final int index;

  BottomnavigationChanging(this.index);
}

part of 'text_change_cubit.dart';

@immutable
abstract class TextChangeState {}

class TextChangeInitial extends TextChangeState {
  final int pageno;

  TextChangeInitial(this.pageno);
}

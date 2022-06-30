part of 'date_picker_cubit.dart';

@immutable
abstract class DatePickerState {}

class DatePickerInitial extends DatePickerState {
  final String datetime;

  DatePickerInitial(this.datetime);
}



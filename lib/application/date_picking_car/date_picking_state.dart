part of 'date_picking_cubit.dart';

@immutable
abstract class DatePickingState {}

class DatePickingInitial extends DatePickingState {}

class DatePickingDone extends DatePickingState {
 final DateTimeRange dateTimeRange;

  DatePickingDone(this.dateTimeRange);
}

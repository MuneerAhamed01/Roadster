part of 'car_details_bloc.dart';

@immutable
abstract class CarDetailsEvent {}

class CarGetDetailsHomePage extends CarDetailsEvent {}

class CarGetDetailDatePicking extends CarDetailsEvent {
  final DateTimeRange range;

  CarGetDetailDatePicking(this.range);
}

class CarGetDetailsBySearch extends CarDetailsEvent {
  final String value;

  CarGetDetailsBySearch(this.value);
}

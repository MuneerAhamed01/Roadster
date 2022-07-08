part of 'car_details_bloc.dart';

@immutable
abstract class CarDetailsEvent {}

class CarGetDetails extends CarDetailsEvent {}

class CarGetDetailsBySearch extends CarDetailsEvent {
  final String value;

  CarGetDetailsBySearch(this.value);
}

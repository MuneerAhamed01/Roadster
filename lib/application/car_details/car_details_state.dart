part of 'car_details_bloc.dart';

@immutable
abstract class CarDetailsState {}

class CarDetailsInitial extends CarDetailsState {}

class CarDetailsOnProcessing extends CarDetailsState {}

class CarDetailsDone extends CarDetailsState {
  final List<Datum> carListByKM;
  final List<Datum> carListByNearBy;
  final List<Datum> carListByTopPick;
  final Position currentPosition;

  CarDetailsDone( {
   required this.currentPosition,
    required this.carListByKM,
    required this.carListByNearBy,
    required this.carListByTopPick,
  });
}

class CarDetailsError extends CarDetailsState {
  final String message;

  CarDetailsError(this.message);
}
class CarDetailsSearch extends CarDetailsState {
  final List<Datum> list;
  final Position currentPosition;

  CarDetailsSearch({required this.list, required this.currentPosition});

  
}
class CarDetailsSearchEmpty extends CarDetailsState {
  

  
}

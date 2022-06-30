part of 'location_controller_cubit.dart';

@immutable
abstract class LocationControllerState {}

class LocationControllerInitial extends LocationControllerState {}

class LocationControllerOnprossesing extends LocationControllerState {}

class LocationControllerOnError extends LocationControllerState {}

class LocationControllerOnSucesss extends LocationControllerState {
  final String district;
  final String address;
  LocationControllerOnSucesss({required this.district, required this.address});
}

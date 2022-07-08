import 'package:geolocator/geolocator.dart';
import 'package:road_ster/domain/models/get_car_details.dart';

String carListKm(Datum carList, Position position) {
  final length = Geolocator.distanceBetween(position.latitude,
      position.longitude, carList.latitude, carList.longitude);
  final km = length / 1000;
  return km.floor().toString();
}

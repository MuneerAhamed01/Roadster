import 'dart:developer';

import 'package:geolocator/geolocator.dart';

import '../domain/models/get_car_details.dart';

class SortingByOrder {
  Future<List<Datum>> sortByKm(List<Datum> carList) async {
    final Position position = await Geolocator.getCurrentPosition();
    carList.sort((a, b) {
      final length1 = Geolocator.distanceBetween(
          position.latitude, position.longitude, a.latitude, a.longitude);

      final length2 = Geolocator.distanceBetween(
          position.latitude, position.longitude, b.latitude, b.longitude);
      log("${length2 / 1000}----------------------${a.model}--${a.brand}------------------------------${length1 / 1000}");

      return length1.compareTo(length2);
    });
    return carList;
  }

  Future<List<Datum>> nearByMe(List<Datum> carList) async {
    List<Datum> nearbyMeList = [];
    for (var e in carList) {
      final Position position = await Geolocator.getCurrentPosition();
      final meters = Geolocator.distanceBetween(
          position.latitude, position.longitude, e.latitude, e.longitude);

      if (meters / 1000 <= 100) {
        nearbyMeList.add(e);
      }
    }
    return nearbyMeList;
  }

  Future<List<Datum>> topPicks(List<Datum> carList) async {
    carList.sort(
      (a, b) => a.bookingcount.compareTo(b.bookingcount),
    );
    return carList;
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';

import '../domain/models/get_car_details.dart';
import 'cache_data_repo.dart';

class SortingByOrder {
  List<Datum> sortByKm(List<Datum> carList, Position position) {
    List<Datum> carListInOrder = [];
    // final double lengthOne;

    carList.sort((a, b) {
      final length1 = Geolocator.distanceBetween(
              position.latitude, position.longitude, a.latitude, a.longitude) /
          1000;
// log("${length1 / 1000}----------------------${a.model}--${a.brand}------------------------------${length1 / 1000}");
      final length2 = Geolocator.distanceBetween(
              position.latitude, position.longitude, b.latitude, b.longitude) /
          1000;
      // log("----------------------${b.model}--${b.brand}------------------------------");
      // log("----------------------${length1}--${length2}------------------------------");

      return length1.compareTo(length2);
    });
    carListInOrder.addAll(carList);

    return carListInOrder;
  }

  List<Datum> nearByMe(List<Datum> carList, Position position) {
    List<Datum> nearbyMeList = [];
    for (var e in carList) {
      final meters = Geolocator.distanceBetween(
          position.latitude, position.longitude, e.latitude, e.longitude);

      if (meters / 1000 <= 100) {
        nearbyMeList.add(e);
      }
    }

    return nearbyMeList;
  }

  List<Datum> topPicks(List<Datum> carList) {
    carList.sort(
      (a, b) => a.bookingcount.compareTo(b.bookingcount),
    );
    return carList;
  }

  static Future<List<Datum>> watchList(String response) async {
    List<Datum> list = [];
    final Map<String,dynamic> fromJson = jsonDecode(response);
   
    final carDetails = await CacheDataRepository().getCarFromCacheData();
    final carDetailsList = getCarDetailsFromJson(carDetails);
    for (var ids in fromJson['wishlist']) {
      for (var cars in carDetailsList.data) {
        if (ids == cars.id) {
          list.add(cars);
        }
      }
    }

    return list;
  }
   static Future<List<String>> watchListIds(String response) async {
    List<String> list = [];
    final Map<String,dynamic> fromJson = jsonDecode(response);
   
    final carDetails = await CacheDataRepository().getCarFromCacheData();
    final carDetailsList = getCarDetailsFromJson(carDetails);
    for (var ids in fromJson['wishlist']) {
      for (var cars in carDetailsList.data) {
        if (ids == cars.id) {
          list.add(cars.id);
        }
      }
    }

    return list;
  }
}

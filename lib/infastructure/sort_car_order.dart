import 'dart:convert';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:road_ster/application/car_details/car_details_bloc.dart';

import '../domain/api_values/api.dart';
import '../domain/models/booking_details.dart';
import '../domain/models/booking_history.dart';
import '../domain/models/get_car_details.dart';
import 'cache_data_repo.dart';
import 'login_and_signup/login_repository.dart';

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
    final Map<String, dynamic> fromJson = jsonDecode(response);

    final carDetails = await CacheDataRepository()
        .getCarFromCacheData(cacheDataFromCarDetails);
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
    final Map<String, dynamic> fromJson = jsonDecode(response);
    String carDetails = '';

    if (await CacheDataRepository().cheackKeyIsThere(cacheDataFromCarDetails)) {
      log("----------------------------------------------------------------------------------------FromAPI------------------------------------------");
      carDetails = await CacheDataRepository()
          .getCarFromCacheData(cacheDataFromCarDetails);
    } else {
      final responeAPI =
          await RepositoryHandler.getCarDetails(ApiValues.getCarDetails);
      log("----------------------------------------------------------------------------------------FrmCacacacaad------------------------------------------");
      await CacheDataRepository()
          .addCarFromCache(responeAPI.data, cacheDataFromCarDetails);
      carDetails = responeAPI.data;
    }
    final carDetailsList = getCarDetailsFromJson(carDetails);
    for (var ids in fromJson['wishlist']) {
      for (var cars in carDetailsList.data) {
        if (ids == cars.id) {
          list.add(cars.id);
        }
      }
    }
    print(list);
    return list;
  }

  static List<String> sortByDateTime(
    List<String> dateValue,
    String bookedList,
  ) {
    List<String> valuesForAvaliablityCheack = [];

    final listOfBooked = getBookingDetailsFromJson(bookedList);
    // print(listOfBooked.data);
    for (var e in listOfBooked.data) {
      if (e.complete == false && e.cancel == false) {
        log("-------------------------coming in map");
        final startDateOfCar = DateFormat("dd/MM/yyyy").parse(e.startDate);
        final endDateOfCar = DateFormat("dd/MM/yyyy").parse(e.endDate);
        final endDateOfCustomer = DateTime.parse(dateValue[1]);
        final startDateOfCustomer = DateTime.parse(dateValue[0]);
        if (startDateOfCustomer.isBetween(startDateOfCar, endDateOfCar) ||
            endDateOfCustomer.isBetween(startDateOfCar, endDateOfCar)) {
          valuesForAvaliablityCheack.add(e.carId);
        }
      }
    }
    // print(valuesForAvaliablityCheack);
    return valuesForAvaliablityCheack;
  }

  List<String> imageLink(
      List<BookingDatum> listOfData, List<Datum> carDetails) {
    List<String> images = [];

    for (var e in carDetails) {
      for (var element in listOfData) {
        if (e.id == element.carId) {
          images.add(e.imgUrl);
        }
      }
    }
    return images;
  }
}

extension DateTimeExtension on DateTime {
  bool? isAfterOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isAfter(dateTime);
    }
    return null;
  }

  bool? isBeforeOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isBefore(dateTime);
    }
    return null;
  }

  bool isBetween(
    DateTime fromDateTime,
    DateTime toDateTime,
  ) {
    final date = this;

    final isAfter = date.isAfterOrEqualTo(fromDateTime) ?? false;
    final isBefore = date.isBeforeOrEqualTo(toDateTime) ?? false;
    return isAfter && isBefore;

    // return null;
  }
}

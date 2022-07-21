import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:road_ster/domain/models/booking_details.dart';
import 'package:road_ster/domain/models/get_car_details.dart';
import 'package:road_ster/infastructure/cache_data_repo.dart';
import 'package:road_ster/infastructure/login_and_signup/login_repository.dart';
import 'package:road_ster/infastructure/sort_car_order.dart';
import 'package:road_ster/main.dart';

import '../../domain/api_values/api.dart';

part 'car_details_event.dart';
part 'car_details_state.dart';

const String cacheDataFromCarDetails = "keyOne";

const String cacheData = "cacheData";
String currrentDistrict = "Null";

class CarDetailsBloc extends Bloc<CarDetailsEvent, CarDetailsState> {
  CarDetailsBloc() : super(CarDetailsInitial()) {
    on<CarGetDetailsHomePage>((event, emit) async {
      emit(CarDetailsOnProcessing());
      String? response = '';
      List<Datum>? carListCheak = [];

      final Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      final district = placemarks[0].subAdministrativeArea;
      currrentDistrict = district!;
      print(currrentDistrict);

      // print(dateValue);

      try {
        if (await CacheDataRepository()
            .cheackKeyIsThere(cacheDataFromCarDetails)) {
          log("----------------------------------------------------------------------------------------FromAPI------------------------------------------");
          response = await CacheDataRepository()
              .getCarFromCacheData(cacheDataFromCarDetails);

          // response = responeAPI.data;
        } else {
          // print("object");
          final responeAPI =
              await RepositoryHandler.getCarDetails(ApiValues.getCarDetails);
          // print(responeAPI.data);
          log("----------------------------------------------------------------------------------------FrmCacacacaad------------------------------------------");
          await CacheDataRepository()
              .addCarFromCache(responeAPI.data, cacheDataFromCarDetails);
          // response = await CacheDataRepository()
          //     .getCarFromCacheData(cacheDataFromCarDetails);
          response = responeAPI.data;
        }

        final carList = getCarDetailsFromJson(response!);
        // print(carList.data.length);
        List<String>? dateValue = preferences.getStringList("carByDate");

        if (dateValue == null || dateValue.isEmpty) {
          carListCheak = carList.data;
        } else {
          final bookedList = await RepositoryHandler.getBookingDetais(
              ApiValues.bookingDetails);
          log("-------------------------coming in else");
          final valuesForAvaliablityCheack =
              SortingByOrder.sortByDateTime(dateValue, bookedList.data);
          carList.data.removeWhere(
              (element) => valuesForAvaliablityCheack.contains(element.id));

          carListCheak = carList.data;
        }
        // print(carListCheak.toString());

        final carListByKm = SortingByOrder().sortByKm(carListCheak, position);
        final carListByNear = SortingByOrder().nearByMe(carListCheak, position);
        final carListByTop = SortingByOrder().topPicks(carListCheak);

        emit(
          CarDetailsDone(
              currentPosition: position,
              carListByKM: carListByKm,
              carListByNearBy: carListByNear,
              carListByTopPick: carListByTop),
        );
      } catch (e) {
        // print("dooo");
        emit(CarDetailsError(e.toString()));
      }
      log("----------------------------------------------------------------------------------------notWorking------------------------------------------");
    });
    on<CarGetDetailDatePicking>((event, emit) async {
      preferences.setStringList("carByDate",
          [event.range.start.toString(), event.range.end.toString()]);

      add(CarGetDetailsHomePage());
    });
    on<CarGetDetailsBySearch>(
      (event, emit) async {
        emit(CarDetailsOnProcessing());
        final Position position = await Geolocator.getCurrentPosition();

        final cacheData = await CacheDataRepository()
            .getCarFromCacheData(cacheDataFromCarDetails);
        final data = getCarDetailsFromJson(cacheData);
        if (event.value.isEmpty) {
          final carList = getCarDetailsFromJson(cacheData);
          // print("-----${carList.data[0].brand}");
          final carListByKm = SortingByOrder().sortByKm(carList.data, position);
          final carListByNear =
              SortingByOrder().nearByMe(carList.data, position);
          final carListByTop = SortingByOrder().topPicks(carList.data);
          // log(response);
          // final List<double> kilometers = carListByKm[1];

          emit(CarDetailsDone(
              currentPosition: position,
              carListByKM: carListByKm,
              carListByNearBy: carListByNear,
              carListByTopPick: carListByTop));
        } else {
          List<Datum>? dataList = data.data
              .where((car) => car.brand
                  .toLowerCase()
                  .trim()
                  .contains(event.value.toLowerCase().trim()))
              .toList();
          // ignore: unnecessary_null_comparison
          if (dataList == null || dataList.isEmpty) {
            // print("object");
            emit(CarDetailsSearchEmpty());
          } else {
            emit(CarDetailsSearch(list: dataList, currentPosition: position));
          }
        }
      },
    );
  }
}

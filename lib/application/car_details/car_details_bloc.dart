import 'dart:developer';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:road_ster/domain/models/get_car_details.dart';
import 'package:road_ster/infastructure/cache_data_repo.dart';
import 'package:road_ster/infastructure/login_and_signup/login_repository.dart';
import 'package:road_ster/infastructure/sort_car_order.dart';

import '../../domain/api_values/api.dart';

part 'car_details_event.dart';
part 'car_details_state.dart';

const String cacheData = "cacheData";

class CarDetailsBloc extends Bloc<CarDetailsEvent, CarDetailsState> {
  CarDetailsBloc() : super(CarDetailsInitial()) {
    on<CarGetDetails>((event, emit) async {
      emit(CarDetailsOnProcessing());
      String? response;
      final Position position = await Geolocator.getCurrentPosition();

      try {
        if (!await CacheDataRepository().cheackKeyIsThere()) {
          log("----------------------------------------------------------------------------------------FromAPI------------------------------------------");

          final responeAPI =
              await RepositoryHandler.getCarDetails(ApiValues.getCarDetails);
          CacheDataRepository().addCarFromCache(responeAPI.data);
          response = await CacheDataRepository().getCarFromCacheData();
        } else {
          log("----------------------------------------------------------------------------------------FrmCacacacaad------------------------------------------");

          response = await CacheDataRepository().getCarFromCacheData();
        }
        final carList = getCarDetailsFromJson(response);
        print("-----${carList.data[0].id}-------------------for test purpose------------------------");
        final carListByKm = SortingByOrder().sortByKm(carList.data, position);
        final carListByNear = SortingByOrder().nearByMe(carList.data, position);
        final carListByTop = SortingByOrder().topPicks(carList.data);
        log(response);
        // final List<double> kilometers = carListByKm[1];

        emit(CarDetailsDone(
            currentPosition: position,
            carListByKM: carListByKm,
            carListByNearBy: carListByNear,
            carListByTopPick: carListByTop));
      } catch (e) {
        emit(CarDetailsError(e.toString()));
      }
      log("----------------------------------------------------------------------------------------notWorking------------------------------------------");
    });
    on<CarGetDetailsBySearch>((event, emit) async {
      emit(CarDetailsOnProcessing());
      final Position position = await Geolocator.getCurrentPosition();

      final cacheData = await CacheDataRepository().getCarFromCacheData();
      final data = getCarDetailsFromJson(cacheData);
      if (event.value.isEmpty) {
        final carList = getCarDetailsFromJson(cacheData);
        // print("-----${carList.data[0].brand}");
        final carListByKm = SortingByOrder().sortByKm(carList.data, position);
        final carListByNear = SortingByOrder().nearByMe(carList.data, position);
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
        if (dataList == null || dataList.isEmpty) {
          print("object");
          emit(CarDetailsSearchEmpty());
        } else {
          emit(CarDetailsSearch(list: dataList, currentPosition: position));
        }
      }

      // TODO: implement event handler
    });
  }
}

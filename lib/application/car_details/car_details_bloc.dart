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
        final carListByKm = await SortingByOrder().sortByKm(carList.data);
        final carListByNear = await SortingByOrder().nearByMe(carList.data);
        final carListByTop = await SortingByOrder().topPicks(carList.data);
        log(response);
        emit(CarDetailsDone(
            carListByKM: carListByKm,
            carListByNearBy: carListByNear,
            carListByTopPick: carListByTop));
      } catch (e) {
        emit(CarDetailsError(e.toString()));
      }
      log("----------------------------------------------------------------------------------------notWorking------------------------------------------");
    });
  }
}

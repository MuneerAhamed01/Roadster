import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:road_ster/domain/api_values/api.dart';
import 'package:road_ster/domain/get_user_details.dart';
import 'package:road_ster/domain/models/get_car_details.dart';
import 'package:road_ster/domain/models/user_login.dart';
import 'package:road_ster/infastructure/cache_data_repo.dart';
import 'package:road_ster/infastructure/login_and_signup/login_repository.dart';
import 'package:road_ster/infastructure/sort_car_order.dart';

import '../../main.dart';

part 'get_watchlist_data_event.dart';
part 'get_watchlist_data_state.dart';

final String cacheWatchList = "watchList";

class GetWatchlistDataBloc
    extends Bloc<GetWatchlistDataEvent, GetWatchlistDataState> {
  GetWatchlistDataBloc() : super(GetWatchlistDataInitial()) {
    on<GetWatchListData>((event, emit) async {
      emit(GetWatchlistDataOnprocess());
      final Position position = await Geolocator.getCurrentPosition();
      String response = '';

      String userId = GetUserDetailsFormSharedPRef().getUserDetails().id;

      final map = {"USERID": userId};

      try {
        if (await CacheDataRepository()
            .cheackKeyIsThereWatchlist(cacheWatchList)) {
          log('this is working   ');
          response = await CacheDataRepository()
              .getCarFromCacheDataWatchlist(cacheWatchList);
        } else {
          final responseOf = await RepositoryHandler.getWatchlistData(
              ApiValues.getWatchList, map);
          CacheDataRepository()
              .addCarFromCacheWatchlist(responseOf.data, cacheWatchList);
          response = responseOf.data;
          // response =
          //     await CacheDataRepository().getCarFromCacheData(cacheWatchList);
        }

        final watchlistCar = await SortingByOrder.watchList(response);
        final watchlistCarIds = await SortingByOrder.watchListIds(response);

        log(watchlistCar.length.toString());
        emit(GetWatchlistDataGetDone(
            carList: watchlistCar, position: position, ids: watchlistCarIds));
      } catch (e) {
        print("-------------${e.toString()}");
        emit(GetWatchlistDataError());
      }
    });
    on<GetWatchListIstrue>((event, emit) async {
      emit(GetWatchlistDataOnprocess());
      final Position position = await Geolocator.getCurrentPosition();

      final responseId = preferences.getString("userData");
      final userId = loginDetailsFromJson(responseId!).id;
      final map = {"USERID": userId};
      try {
        final response = await RepositoryHandler.getWatchlistData(
            ApiValues.getWatchList, map);
        // print("hae");
        final watchlistCar = await SortingByOrder.watchListIds(response.data);
        log(watchlistCar.length.toString());
        emit(GetWatchlistDataGetDone(ids: watchlistCar, position: position));
      } catch (e) {
        print("-----${e.toString()}");
        emit(GetWatchlistDataError());
      }
    });
    on<GetWatchListBySearch>((event, emit) async {
      emit(GetWatchlistDataOnprocess());
      final Position position = await Geolocator.getCurrentPosition();
      // String dataPassingBySearch = '';
      List<Datum> searchList = [];

      final responseId = preferences.getString("userData");
      final userId = loginDetailsFromJson(responseId!).id;

      final map = {"USERID": userId};

      try {
        final response =
            await CacheDataRepository().getCarFromCacheData(cacheWatchList);
        if (event.value.isNotEmpty) {
          final watchlistCar = await SortingByOrder.watchList(response);
          searchList = watchlistCar
              .where(
                  (car) => car.brand.toLowerCase().trim().contains(event.value))
              .toList();
          // watchlistCar = searchList;
        } else {
          final watchlistCar = await SortingByOrder.watchList(response);

          searchList = watchlistCar;
        }
        final watchlistCar = await SortingByOrder.watchList(response);
        final watchlistCarIds = await SortingByOrder.watchListIds(response);

        log(watchlistCar.length.toString());
        emit(GetWatchlistDataGetDone(
            carList: searchList, position: position, ids: watchlistCarIds));
      } catch (e) {
        print(e.toString());
        emit(GetWatchlistDataError());
      }
    });
  }
}

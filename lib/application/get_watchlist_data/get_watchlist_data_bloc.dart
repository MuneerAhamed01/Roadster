
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:road_ster/domain/api_values/api.dart';
import 'package:road_ster/domain/models/get_car_details.dart';
import 'package:road_ster/domain/models/user_login.dart';
import 'package:road_ster/infastructure/login_and_signup/login_repository.dart';
import 'package:road_ster/infastructure/sort_car_order.dart';

import '../../main.dart';

part 'get_watchlist_data_event.dart';
part 'get_watchlist_data_state.dart';

class GetWatchlistDataBloc
    extends Bloc<GetWatchlistDataEvent, GetWatchlistDataState> {
  GetWatchlistDataBloc() : super(GetWatchlistDataInitial()) {
    on<GetWatchListData>((event, emit) async {
     
      emit(GetWatchlistDataOnprocess());
      final Position position = await Geolocator.getCurrentPosition();

      final responseId = preferences.getString("userData");
      final userId = loginDetailsFromJson(responseId!).id;

      final map = {"USERID": userId};
      try {
        final response = await RepositoryHandler.getWatchlistData(
            ApiValues.getWatchList, map);
        final watchlistCar = await SortingByOrder.watchList(response.data);
        final watchlistCarIds = await SortingByOrder.watchListIds(response.data);

        log(watchlistCar.length.toString());
        emit(GetWatchlistDataGetDone(carList: watchlistCar,position: position,ids: watchlistCarIds));
      } catch (e) {
        print(e.toString());
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
        final watchlistCar = await SortingByOrder.watchListIds(response.data);
        log(watchlistCar.length.toString());
        emit(GetWatchlistDataGetDone(ids: watchlistCar,position:position ));
      } catch (e) {
        print(e.toString());
        emit(GetWatchlistDataError());
      }
    });
  }
}

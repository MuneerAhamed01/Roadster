import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:road_ster/domain/api_values/api.dart';
import 'package:road_ster/infastructure/login_and_signup/login_repository.dart';

import '../../domain/models/user_login.dart';
import '../../main.dart';

part 'watchlistbutton_state.dart';

class WatchlistbuttonCubit extends Cubit<WatchlistbuttonState> {
  WatchlistbuttonCubit() : super(WatchlistbuttonInitial());
  void addToWatchlist(String carId) async {
    emit(WatchlistbuttonOnProcess(cheackIsOnWachList: true));

    final responseId = preferences.getString("userData");
    final userId = loginDetailsFromJson(responseId!).id;

    final map = {"USERID": userId};
    try {
      await RepositoryHandler.addtoWatchlist(
          ApiValues.addTowatchlist + carId, map);
      // emit(WatchlistbuttonOnProcess(cheackIsOnWachList: true));
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteFromWatchList(String carId) async {
    print("---------------------------------$carId------------------------deleting");
    emit(WatchlistbuttonOnProcess(cheackIsOnWachList: false));

    final responseId = preferences.getString("userData");
    final userId = loginDetailsFromJson(responseId!).id;

    final map = {"USERID": userId};
    try {
      await RepositoryHandler.addtoWatchlist(
          ApiValues.removefromWatchList + carId, map);
      // emit(WatchlistbuttonOnProcess(cheackIsOnWachList: false));
    } catch (e) {
      print('haiiiii');
      print(e.toString());
    }
  }
}

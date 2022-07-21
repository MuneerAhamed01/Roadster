import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:road_ster/domain/api_values/api.dart';

part 'getsinglecarbid_state.dart';

class GetsinglecarbidCubit extends Cubit<GetsinglecarbidState> {
  GetsinglecarbidCubit() : super(GetsinglecarbidInitial());
  void getCar(String id) async {
    emit(GetsinglecarbidInitial());
    try {
      print("IS working everyTime");
      final response =
          await Dio().post(ApiValues.baseUrl + ApiValues.getSingleCarById + id);
      log("------------------${response.data}");
      emit(GetsinglecarbidOnGet(response.data['imgUrl']));
    } catch (e) {
      print(e.toString());
    }
  }
}

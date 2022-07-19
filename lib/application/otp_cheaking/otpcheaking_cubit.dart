import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:road_ster/domain/api_values/api.dart';
import 'package:road_ster/domain/models/user_login.dart';
import 'package:road_ster/domain/models/users_datas.dart';
import 'package:road_ster/infastructure/login_and_signup/login_repository.dart';

import '../../main.dart';

part 'otpcheaking_state.dart';

class OtpcheakingCubit extends Cubit<OtpcheakingState> {
  OtpcheakingCubit() : super(OtpcheakingInitial());
  void otpCheaking(int phoneNo) async {
    //   final pref = preferences.getString("userDetailsFull");
    // final userId = loginDetailsFromJson(pref!).id;
    if (preferences.getString("userDetailsFull") != null ||
        preferences.getString("userDetailsFull")!.isNotEmpty) {
      final res = preferences.getString("userDetailsFull");
      // print(res);
      final jsonData = jsonDecode(res!);
      final loginRes = GetUsersDetails.fromJson(jsonData['user']);
      // print(object)
      // print(loginRes.phone);

      if (loginRes.phone != phoneNo) {
        // print
        emit(OtpcheakingMobileNoError());
        return;
      }
    }
    emit(OtpcheakingOnprocess());

    final Map<String, dynamic> json = {"mobNumber": phoneNo};

    try {
      final response =
          await RepositoryHandler.otpValidate(json, ApiValues.otpurl);
      log("-----------------------------------------${response.data}");
      emit(OtpcheakingOnMobcheack());
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        emit(OtpcheakMobError("Mobile No. is not valid"));
      }
    } catch (e) {
      emit(OtpcheakMobError(e.toString()));
    }
  }

  void otpValidation(int phoneNo, int otp) async {
    final Map<String, dynamic> json = {"otp": otp, "mobNumber": phoneNo};

    try {
      final response =
          await RepositoryHandler.otpValidate(json, ApiValues.otpgetUrl);
      preferences.setString("userDetailsFull", response.data);

      loginDetailsFromJson(response.data);
      emit(OtpcheakingOnMobcheack());
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        emit(OtpcheakMobError("OTP is wrong"));
      }
    } catch (e) {
      emit(OtpcheakMobError(e.toString()));
    }
  }
}

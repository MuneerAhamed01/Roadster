import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:road_ster/domain/models/user_login.dart';
import 'package:road_ster/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/core/asset_images.dart';

part 'splashscreen_state.dart';

class SplashscreenCubit extends Cubit<SplashscreenState> {
  SplashscreenCubit() : super(SplashscreenInitial());
  void stateCheaking(BuildContext context) async {
    await precacheImage(const AssetImage(ImagesStrings.imageSplash), context);
    await precacheImage(
        const AssetImage(ImagesStrings.backgroundImageOTP), context);
    await precacheImage(
        const AssetImage(ImagesStrings.backgroundImageOTP2), context);

    LocationPermission permission;

    // Test if location services are enabled.
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final response = preferences.getString("userData");

    if (response == null || response.isEmpty) {
      await Future.delayed(const Duration(seconds: 2));
      emit(SplashscreenOnBoard());
    } else {
      final responseDaat = loginDetailsFromJson(response);
      print(responseDaat.id);
      emit(SplashscreenHomePage());
    }
  }
}

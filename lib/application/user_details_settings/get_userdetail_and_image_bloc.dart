import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import 'package:road_ster/domain/api_values/api.dart';
import 'package:road_ster/domain/models/user_login.dart';
import 'package:road_ster/infastructure/login_and_signup/login_repository.dart';
import 'package:road_ster/main.dart';

import '../../domain/models/users_datas.dart';

part 'get_userdetail_and_image_event.dart';
part 'get_userdetail_and_image_state.dart';

class GetUserdetailAndImageBloc
    extends Bloc<GetUserdetailAndImageEvent, GetUserdetailAndImageState> {
  GetUserdetailAndImageBloc() : super(GetUserdetailAndImageInitial()) {
    on<GetDetailsSettings>((event, emit) async {
      emit(GetUserdetailAndImageOnProcess());
      final pref = preferences.getString("userData");
      final userId = loginDetailsFromJson(pref!);
      String imageUrl = '';
      try {
        final response = await RepositoryHandler.getUserProfile(
            ApiValues.userDetails + userId.id);
       await preferences.setString("userDetailsFull", response.data);
        print(response.data);
        final storage = FirebaseStorage.instance
            .ref()
            .child("ProfilePicture")
            .child("${userId.email}.jpg");
        try {
          imageUrl = await storage.getDownloadURL();
        } catch (e) {
          print("object");
        }
        // print("--------------------------------------------------$imageUrl");
        final json = jsonDecode(response.data);
        final userDetails = GetUsersDetails.fromJson(json['user']);
        // print(userDetails.toString());

        emit(GetUserdetailAndImageOnDone(
            imageUrl: imageUrl, usersDetails: userDetails));
      } catch (e) {
        print(
            "------------------------------------------------------------${e.toString()}");
      }
    });
  }
}

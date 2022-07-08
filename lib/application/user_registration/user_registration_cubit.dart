import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:road_ster/domain/models/user_login.dart';
import 'package:road_ster/infastructure/login_and_signup/login_repository.dart';

import '../../main.dart';

part 'user_registration_state.dart';

class UserRegistrationCubit extends Cubit<UserRegistrationState> {
  UserRegistrationCubit() : super(UserRegistrationInitial());
  void registerNewAccount(
      {required String name,
      required File? fileImage,
      required String email,
      required String gender,
      required String address,
      required String district,
      required String password,
      required String age,
      required int phone}) async {
    emit(UserRegistrationOnprosess());
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy').format(now);
    final dob = age.split("").getRange(age.length - 4, age.length).join();
    final int userAge = int.parse(formattedDate) - int.parse(dob);

    if (fileImage != null) {
      final storage = FirebaseStorage.instance
          .ref()
          .child("ProfilePicture")
          .child("$email.jpg");
      storage.putFile(fileImage);
    }

    print(userAge);

    final Map<String, dynamic> signUp = {
      "name": name,
      "email": email,
      'phone': phone,
      "age": userAge,
      "gender": gender,
      "address": address,
      "district": district,
      "password": password,
      
    };
    try {
      print("--------------------------------------------------going");
      
      await RepositoryHandler.registerUser(signUp);
      print("--------------------------------------------------");
      // await preferences.setString("userData", response.data);

      // loginDetailsFromJson(response.data);
      emit(UserRegistrationOnsuccess());
    } catch (e) {
      log("--------------------------------------------------");

      print(e.toString());
      emit(UserRegistrationOnError(e.toString()));
    }
  }
}

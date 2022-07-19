import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:road_ster/domain/api_values/api.dart';
import 'package:road_ster/infastructure/login_and_signup/login_repository.dart';

import '../../domain/models/user_login.dart';
import '../../main.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  void resetPassword(String password) async {
    emit(ResetPasswordOnprocess());
    final pref = preferences.getString("userData");
    final userId = loginDetailsFromJson(pref!).id;
    final map = {"password": password};

    try {
      final response = await RepositoryHandler.passwordUpdate(
          map, ApiValues.resetPassword + userId);
      print(response.data.toString());
      emit(ResetPasswordOnDone());
    } catch (e) {
      // print(e.toString());
      emit(ResetPasswordOnError());
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:road_ster/domain/models/user_login.dart';
import 'package:road_ster/infastructure/login_and_signup/login_repository.dart';
import 'package:road_ster/main.dart';

part 'user_login_state.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  UserLoginCubit() : super(UserLoginInitial());

  void loginComing(String email, String password) async {
    emit(UserLoginOnProcess());
    Map<String, dynamic> login = {"email": email, "password": password};

    try {
      print("data");
      final response = await RepositoryHandler.loginCheaking(login);

      await preferences.setString("userData", response.data);
      loginDetailsFromJson(response.data);
      print("--${response.data}----");

      emit(UserLoginOnSucess());
    } catch (e) {
      print(e.toString());
      emit(UserLoginOnError(e.toString()));
    }
  }
}

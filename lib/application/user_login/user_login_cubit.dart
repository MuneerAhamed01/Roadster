import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:road_ster/domain/models/user_login.dart';
import 'package:road_ster/infastructure/login_and_signup/login_repository.dart';

part 'user_login_state.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  UserLoginCubit() : super(UserLoginInitial());

  void loginComing(String email, String password) async {
    emit(UserLoginOnProcess());
    Map<String, dynamic> login = {"email": email, "password": password};

    try {
      final response = await RepositoryHandler.loginCheaking(login);
      loginDetailsFromJson(response.data);

      emit(UserLoginOnSucess());
    } catch (e) {
      print(e);
      emit(UserLoginOnError(e.toString()));
    }
  }
}

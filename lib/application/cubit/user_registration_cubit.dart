import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:road_ster/infastructure/login_and_signup/login_repository.dart';

part 'user_registration_state.dart';

class UserRegistrationCubit extends Cubit<UserRegistrationState> {
  UserRegistrationCubit() : super(UserRegistrationInitial());
  void registerNewAccount(
      {required String name,
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
    print(userAge);

    final Map<String, dynamic> signUp = {
      "name": name,
      "email": email,
      'phone': phone,
      "age": userAge,
      "gender": gender,
      "address": address,
      "district": district,
      "password": password
    };
    try {
      final response = await RepositoryHandler.registerUser(signUp);
      print(response.data.toString());
      emit(UserRegistrationOnsuccess());
    } catch (e) {
      print(e.toString());
      emit(UserRegistrationOnError(e.toString()));
    }
  }
}

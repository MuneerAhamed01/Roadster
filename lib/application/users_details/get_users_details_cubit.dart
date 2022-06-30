import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:road_ster/domain/models/users_datas.dart';
import 'package:road_ster/infastructure/login_and_signup/login_repository.dart';

part 'get_users_details_state.dart';

class GetUsersDetailsCubit extends Cubit<GetUsersDetailsState> {
  GetUsersDetailsCubit() : super(GetUsersDetailsInitial(const[]));

  void getUserDetails() async {
    try {
      final response = await RepositoryHandler.getUsersDetails();
      final getData = getUsersDetailsFromJson(response.data);
      emit(GetUsersDetailsInitial(getData));
    } catch (e) {
      print(e.toString());
    }
  }
}

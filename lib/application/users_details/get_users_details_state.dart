part of 'get_users_details_cubit.dart';

@immutable
abstract class GetUsersDetailsState {}

class GetUsersDetailsInitial extends GetUsersDetailsState {
  final List<GetUsersDetails> details;

  GetUsersDetailsInitial(this.details);
}

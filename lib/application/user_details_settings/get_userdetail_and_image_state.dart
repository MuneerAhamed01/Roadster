part of 'get_userdetail_and_image_bloc.dart';

@immutable
abstract class GetUserdetailAndImageState {}

class GetUserdetailAndImageInitial extends GetUserdetailAndImageState {}

class GetUserdetailAndImageOnProcess extends GetUserdetailAndImageState {}

class GetUserdetailAndImageOnDone extends GetUserdetailAndImageState {
  final String? imageUrl;
  final GetUsersDetails usersDetails;

  GetUserdetailAndImageOnDone({ this.imageUrl,required this.usersDetails});
}

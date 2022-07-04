part of 'image_picking_cubit.dart';

@immutable
abstract class ImagePickingState {}

class ImagePickingInitial extends ImagePickingState {}

class ImagePickingOnDone extends ImagePickingState {
  final File fileImage;

  ImagePickingOnDone(this.fileImage);
}

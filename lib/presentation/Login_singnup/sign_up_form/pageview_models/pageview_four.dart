import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:road_ster/application/image_picking/image_picking_cubit.dart';
import 'package:road_ster/domain/core/sizedboxes.dart';

import '../../../../domain/core/asset_images.dart';
import '../../../../domain/core/colors.dart';

class PageViewModelFour extends StatelessWidget {
  const PageViewModelFour({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickingCubit, ImagePickingState>(
        builder: (context, state) {
      return Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 250,
                color: Colors.black.withOpacity(0.5),
              ),
              Positioned(
                bottom: -130.h,
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 130.r,
                    child: state is ImagePickingOnDone
                        ? GestureDetector(
                            onTap: () {
                              Get.bottomSheet(BlocProvider.value(
                                  value: BlocProvider.of<ImagePickingCubit>(
                                      context),
                                  child: const ImagePickingWidget()));
                            },
                            child: CircleAvatar(
                              radius: 125.r,
                              backgroundImage: FileImage(state.fileImage),
                            ),
                          )
                        : CircleAvatar(
                            backgroundImage:
                                AssetImage(ImagesStrings.profilePicnull),
                            radius: 125.r,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10)),
                              width: 80,
                              height: 30,
                              child: MaterialButton(
                                  onPressed: () {
                                    Get.bottomSheet(BlocProvider.value(
                                        value:
                                            BlocProvider.of<ImagePickingCubit>(
                                                context),
                                        child: const ImagePickingWidget()));
                                  },
                                  child: Text(
                                    "Add Photo",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10.sp),
                                  )),
                            ),
                          )),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
            child: Text(
              'Add a profile Picture for Identify you.If you are not comfortable you can skip it',
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                  color: optionalText, fontWeight: FontWeight.w600),
            ),
          )
        ],
      );
    });
  }
}

class ImagePickingWidget extends StatelessWidget {
  const ImagePickingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<ImagePickingCubit>(context),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            height: 150,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 30),
              child: Column(
                children: [
                  CameraButton(
                    color: Colors.green,
                    icon: FontAwesomeIcons.cameraRetro,
                    text: 'Camera',
                    ontap: () {
                      Get.back();
                      context
                          .read<ImagePickingCubit>()
                          .onImagePick(ImageSource.camera);
                    },
                  ),
                  h30,
                  CameraButton(
                      color: Colors.orange,
                      ontap: () {
                        Get.back();

                        context
                            .read<ImagePickingCubit>()
                            .onImagePick(ImageSource.gallery);
                      },
                      icon: FontAwesomeIcons.fileImage,
                      text: "Gallery")
                ],
              ),
            ),
          ),
        ));
  }
}

class CameraButton extends StatelessWidget {
  const CameraButton({
    Key? key,
    required this.ontap,
    required this.icon,
    required this.text,
    required this.color,
  }) : super(key: key);
  final Function() ontap;
  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          w20,
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
          )
        ],
      ),
    );
  }
}

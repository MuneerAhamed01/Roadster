import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:road_ster/domain/core/asset_images.dart';
import 'package:road_ster/domain/models/users_datas.dart';
import 'package:road_ster/domain/validations/login_validation.dart';
import 'package:road_ster/presentation/Login_singnup/sign_up_form/sign_up.dart';

import '../../../../application/date_picker/date_picker_cubit.dart';
import '../../../../application/get_location/location_controller_cubit.dart';
import '../../../../domain/core/sizedboxes.dart';

class PageViewModelTwo extends StatelessWidget {
  const PageViewModelTwo({
    Key? key,
    required this.dateController,
    this.onChangedGender,
    required this.districtController,
    required this.adressController,
    required this.formkey,
  }) : super(key: key);

  final TextEditingController dateController;
  final TextEditingController districtController;
  final TextEditingController adressController;
  final GlobalKey<FormState> formkey;

  final void Function(Gender?)? onChangedGender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 120.h),
      child: SingleChildScrollView(
        child: BlocListener<LocationControllerCubit, LocationControllerState>(
            listener: (context, state) {
              if (state is LocationControllerOnSucesss) {
                Get.back();
                districtController.text = state.district;
                adressController.text = state.address;
              } else if (state is LocationControllerOnprossesing) {
                Get.defaultDialog(
                    title: "",
                    content: Lottie.asset(ImagesStrings.lottieLoading,
                        width: 100, height: 100));
              }
            },
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 29.h),
                      child: const HeadingTextSignup(
                        text: "Select your Gender :",
                      )),
                  h20,
                  GenderPickerWithImage(
                    onChanged: onChangedGender,
                    showOtherGender: true,
                  ),
                  h30,
                  Padding(
                      padding: EdgeInsets.only(left: 25.h),
                      child: const HeadingTextSignup(
                        text: "Select you date of birth :",
                      )),
                  h20,
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: BlocListener<DatePickerCubit, DatePickerState>(
                      listener: (context, state) {
                        state as DatePickerInitial;

                        dateController.text = state.datetime;
                      },
                      child: TextFieldCustomized(
                           validator: (p0) =>
                          ValidationTextField.locationValidation(p0, value: 10),
                        controller: dateController,
                        hintText: "DateTime",
                        value: true,
                        onTap: () {
                          context
                              .read<DatePickerCubit>()
                              .onTapTextfield(context);
                        },
                      ),
                    ),
                  ),
                  h30,
                  Padding(
                    padding: EdgeInsets.only(left: 25.h, right: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const HeadingTextSignup(
                          text: "Enter Your Address :",
                        ),
                        SizedBox(
                          height: 30.h,
                          width: 45.w,
                          child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<LocationControllerCubit>()
                                    .onPressButton();
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 9.w),
                                child: Icon(
                                  Icons.gps_fixed,
                                  size: 14.sp,
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  h20,
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: TextFieldCustomized(
                      controller: districtController,
                      hintText: "District",
                      validator: (p0) =>
                          ValidationTextField.locationValidation(p0, value: 4),
                    ),
                  ),
                  h20,
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: TextFieldCustomized(
                      controller: adressController,
                      validator: (p0) =>
                          ValidationTextField.locationValidation(p0, value: 10),
                      hintText: "Address",
                      maxLine: 4,
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

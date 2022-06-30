import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:road_ster/application/users_details/get_users_details_cubit.dart';
import 'package:road_ster/domain/validations/login_validation.dart';
import 'package:road_ster/presentation/Login_singnup/sign_up_form/sign_up.dart';

import '../../../../domain/core/asset_images.dart';
import '../../../../domain/core/sizedboxes.dart';

class PageViewModelOne extends StatelessWidget {
  const PageViewModelOne({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    this.formKey,
  }) : super(key: key);
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final GlobalKey<FormState>? formKey;

  // final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUsersDetailsCubit, GetUsersDetailsState>(
      builder: (context, state) {
        state as GetUsersDetailsInitial;
        return Padding(
          padding: EdgeInsets.only(top: 100.h),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Container(
                      height: 180.h,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(ImagesStrings.carImageTwo),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  h30,
                  const HeadingTextSignup(text: "Add your Personal details :"),
                  h50,
                  TextFieldCustomized(
                    validator: (value) =>
                        ValidationTextField.nameValidation(value),
                    textInputAction: TextInputAction.next,
                    hintText: "Name",
                    controller: nameController,
                  ),
                  h20,
                  TextFieldCustomized(
                    controller: emailController,
                    validator: (value) => ValidationTextField.emailValidations(
                        value,
                        details: state.details),
                    textInputAction: TextInputAction.next,
                    hintText: "Email",
                  ),
                  h20,
                  TextFieldCustomized(
                    validator: (value) => ValidationTextField.phoneNoValidation(
                        value,
                        details: state.details),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    hintText: "Phone No.",
                    controller: phoneController,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:road_ster/application/password_visible/paswordvisible_cubit.dart';
import 'package:road_ster/domain/validations/login_validation.dart';
import 'package:road_ster/presentation/Login_singnup/login_form/textfieldlogin.dart';
import 'package:road_ster/presentation/Login_singnup/sign_up_form/sign_up.dart';

import '../../../../domain/core/asset_images.dart';
import '../../../../domain/core/colors.dart';
import '../../../../domain/core/sizedboxes.dart';

class PageViewModelthree extends StatelessWidget {
  const PageViewModelthree({
    Key? key,
    required this.passwordController,
    required this.passwordConfirmController, required this.formkey,
  }) : super(key: key);
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  final GlobalKey<FormState> formkey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Form(
          key:formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create New Password",
                style:
                    GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              h10,
              Text(
                "Create a password for protect your account",
                style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: optionalText),
              ),
              h30,
              TextFieldCustomized(
                hintText: "Password",
                textObstact: true,
                validator: (value) =>
                    ValidationTextField.passwordValidation(value),
                controller: passwordController,
              ),
              h20,
              BlocBuilder<PaswordvisibleCubit, PaswordvisibleState>(
                builder: (context, state) {
                  state as PaswordvisibleInitial;
                  return TextFieldCustomized(
                    validator: (p0) => ValidationTextField.passwordValidation(
                      p0,
                      cheakValue: passwordController.text,
                    ),
                    hintText: "Confirm Password",
                    textObstact: state.initial,
                    controller: passwordConfirmController,
                    suffix: SuffixIcon(
                        padding: 2.h,
                        stateValue: state.initial,
                        iconData: state.initial
                            ? Icons.remove_red_eye
                            : Icons.visibility_off),
                  );
                },
              ),
              h30,
              Align(
                alignment: Alignment.center,
                child: Lottie.asset(
                  ImagesStrings.passwordImage,
                  height: 300,
                  width: 300,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

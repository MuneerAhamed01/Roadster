import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:road_ster/application/otp_cheaking/otpcheaking_cubit.dart';
import 'package:road_ster/domain/core/asset_images.dart';
import 'package:road_ster/domain/core/colors.dart';
import 'package:road_ster/domain/core/sizedboxes.dart';
import 'package:road_ster/domain/validations/login_validation.dart';
import 'package:road_ster/presentation/Login_singnup/login_form/login_page.dart';
import 'package:road_ster/presentation/Login_singnup/login_form/textfieldlogin.dart';
import 'package:road_ster/presentation/Login_singnup/widget/text_button.dart';

import 'otp_pin.dart';

class OtpLoginNumber extends StatelessWidget {
  OtpLoginNumber({Key? key}) : super(key: key);
  final TextEditingController _controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpcheakingCubit(),
      child: BlocListener<OtpcheakingCubit, OtpcheakingState>(
        listener: (context, state) {
          if (state is OtpcheakingOnprocess) {
            Get.to(() => OTPpinGenerate(
                  mobileNo: _controller.text,
                ));
            log("--------------------Onprocess--------------------------------");
            // Get.defaultDialog(
            //     title: "",
            //     content: Padding(
            //       padding: EdgeInsets.only(bottom: 5.h),
            //       child: Lottie.asset(ImagesStrings.lottieLoading,
            //           width: 100, height: 100),
            //     ));
          } else if (state is OtpcheakingOnMobcheack) {
            log("--------------------OnDone--------------------------------");
          } else if (state is OtpcheakMobError) {
            log("--------------------onError--------------------------------");

            // Get.back();
            Get.showSnackbar(GetSnackBar(
              title: "Error",
              message: state.message,
              snackPosition: SnackPosition.TOP,
            ));
            Future.delayed(const Duration(milliseconds: 2000))
                .then((value) => Get.closeCurrentSnackbar());
          }
        },
        child: Builder(builder: (context) {
          return Scaffold(
            backgroundColor: Colors.grey[800],
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 780.h,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage(ImagesStrings.backgroundImageOTP),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(30.r))),
                    child: SafeArea(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 60, left: 20, right: 20),
                        child: Column(
                          children: [
                            Text(
                              "Enter the Mobile No.",
                              style: GoogleFonts.outfit(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            h20,
                            Text(
                              "We Will send you a one time password to this  Mobile Number",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.outfit(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                            h30,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Form(
                                key: formKey,
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  maxLength: 10,
                                  controller: _controller,
                                  cursorColor: Colors.white,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(top: 20.h, left: 5.w),
                                      border: inputOTP(),
                                      enabledBorder: inputOTP(),
                                      focusedBorder: inputOTP()),
                                  validator: (value) =>
                                      ValidationTextField.phoneNoValidation(
                                          value),
                                ),
                              ),
                            ),
                            h40,
                            Container(
                              height: 40,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: MaterialButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    context
                                        .read<OtpcheakingCubit>()
                                        .otpCheaking(
                                            int.parse(_controller.text));
                                  }
                                },
                                child: Text(
                                  "Submit",
                                  style: GoogleFonts.outfit(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 80.w, top: 30.h),
                    child: TextButtonCustomized(
                        color: Colors.white,
                        textWithoutButton: "Login With Your Email !",
                        textWithButton: "Click Here",
                        fontSize: 14,
                        ontap: () {
                          Get.off(() => LoginPage());
                        }),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  UnderlineInputBorder inputOTP() {
    return UnderlineInputBorder(borderSide: BorderSide(color: Colors.white));
  }
}

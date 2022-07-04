import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_ster/application/otp_cheaking/otpcheaking_cubit.dart';
import 'package:road_ster/application/otp_timer/otpresendtimer_cubit.dart';
import '../../../domain/core/asset_images.dart';
import '../../../domain/core/sizedboxes.dart';
import '../../bottom_nav/bottomnavigation_page.dart';
import '../login_form/login_page.dart';
import '../widget/text_button.dart';

class OTPpinGenerate extends StatefulWidget {
  const OTPpinGenerate({Key? key, required this.mobileNo}) : super(key: key);
  final String mobileNo;

  @override
  State<OTPpinGenerate> createState() => _OTPpinGenerateState();
}

class _OTPpinGenerateState extends State<OTPpinGenerate> {
  @override
  void initState() {
    super.initState();
  }

  int? otp;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OtpcheakingCubit(),
        ),
        BlocProvider(
          create: (context) => OtpresendtimerCubit(),
        )
      ],
      child: Builder(builder: (context) {
        context.read<OtpresendtimerCubit>().timerCheack(31);
        return BlocListener<OtpcheakingCubit, OtpcheakingState>(
          listener: (context, state) {
            if (state is OtpcheakingOnprocess) {
              log("--------------------Onprocess--------------------------------");
              // Get.defaultDialog(
              //     title: "",
              //     content: Padding(
              //       padding: EdgeInsets.only(bottom: 5.h),
              //       child: Lottie.asset(ImagesStrings.lottieLoading,
              //           width: 100, height: 100),
              //     ));
            } else if (state is OtpcheakingOnMobcheack) {
              context.read<OtpresendtimerCubit>().timerCheack(1);

              Get.offAll(() => const BottomNavigation());
              log("--------------------OnDone--------------------------------");
            } else if (state is OtpcheakMobError) {
              log("--------------------onError--------------------------------");

              Get.back();
              Get.showSnackbar(GetSnackBar(
                title: "Error",
                message: state.message,
                snackPosition: SnackPosition.TOP,
              ));
              Future.delayed(const Duration(milliseconds: 2000))
                  .then((value) => Get.closeCurrentSnackbar());
            }
          },
          child: Scaffold(
            backgroundColor: Colors.grey[800],
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 780.h,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            opacity: 0.5,
                            image:
                                AssetImage(ImagesStrings.backgroundImageOTP2),
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
                              "OTP Verification",
                              style: GoogleFonts.outfit(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            h20,
                            Text(
                              "We Will send you a one time password on this  Mobile Number +91 ${widget.mobileNo}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.outfit(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                            h50,
                            OtpTextField(
                              onSubmit: (value) {
                                otp = int.parse(value);
                              },
                              margin: EdgeInsets.only(right: 10.w),
                              borderWidth: 1,
                              showFieldAsBox: true,
                              autoFocus: true,
                              showCursor: false,
                              fieldWidth: 60,
                              borderRadius: BorderRadius.circular(30),
                              textStyle: const TextStyle(color: Colors.white),
                              // hasCustomInputDecoration: true,
                            ),
                            h50,
                            Container(
                              height: 40,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: MaterialButton(
                                onPressed: () {
                                  context
                                      .read<OtpcheakingCubit>()
                                      .otpValidation(
                                          int.parse(widget.mobileNo), otp!);
                                },
                                child: Text(
                                  "Submit",
                                  style: GoogleFonts.outfit(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            h20,
                            BlocBuilder<OtpresendtimerCubit,
                                OtpresendtimerState>(
                              builder: (context, state) {
                                if (state is OtpresendtimeroncountingFinished) {
                                  return Padding(
                                    padding: EdgeInsets.only(left: 90.w),
                                    child: TextButtonCustomized(
                                        textWithoutButton:
                                            "Didn't Receive OTP? ",
                                        textWithButton: "Resend",
                                        fontSize: 14,
                                        ontap: () {
                                          context
                                              .read<OtpcheakingCubit>()
                                              .otpValidation(
                                                  int.parse(widget.mobileNo),
                                                  otp!);
                                        },
                                        color: Colors.white),
                                  );
                                } else {
                                  return Text(
                                      state is OtpresendtimerOncounting
                                          ? state.countValue.toString()
                                          : "30",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold));
                                }
                              },
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
          ),
        );
      }),
    );
  }
}

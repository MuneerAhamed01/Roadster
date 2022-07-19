import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_ster/application/otp_cheaking/otpcheaking_cubit.dart';
import 'package:road_ster/application/otp_timer/otpresendtimer_cubit.dart';
import 'package:road_ster/application/reset_password/reset_password_cubit.dart';
import 'package:road_ster/domain/core/widgets/back_buttton.dart';
import 'package:road_ster/domain/core/widgets/border_radius.dart';
import 'package:road_ster/domain/validations/login_validation.dart';
// import 'package:road_ster/presentation/Login_singnup/login_with_otp/otp_mobile_no.dart';
import 'package:road_ster/presentation/Login_singnup/sign_up_form/sign_up.dart';

import '../../../../domain/core/sizedboxes.dart';

// ignore: must_be_immutable
class ResetPassword extends StatelessWidget {
  ResetPassword({Key? key}) : super(key: key);
  final _key = GlobalKey<FormState>();
  final _keyPassword = GlobalKey<FormState>();
  int otp = 0;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // create: ,
      providers: [
        BlocProvider(create: (context) => OtpcheakingCubit()),
        BlocProvider(create: (context) => OtpresendtimerCubit()),
        BlocProvider(create: (context) => ResetPasswordCubit()),
      ],

      child: BlocConsumer<OtpcheakingCubit, OtpcheakingState>(
          listener: (context, state) {
        if (state is OtpcheakingOnprocess) {
          context.read<OtpresendtimerCubit>().timerCheack(31);
        }
      }, builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const CustomizedBackButton(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Visibility(
                    visible: state is OtpcheakingOnMobcheack,
                    replacement: _forOTP(context: context),
                    child: _passwordReset(context: context),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Column _forOTP({required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        h20,
        Text(
          "Confirm it's you",
          style: GoogleFonts.lato(fontSize: 28.sp, fontWeight: FontWeight.bold),
        ),
        h20,
        _headingTextSettings("Enter the mobile no."),
        h5,
        Form(
          key: _key,
          child: TextFieldCustomized(
            input: [LengthLimitingTextInputFormatter(10)],
            keyboardType: TextInputType.number,
            controller: _phoneController,
            // textInputAction: TextInputAction.next,
            validator: (no) => ValidationTextField.phoneNoValidation(no),
            onFieldSubmitted: (value) {
              if (_key.currentState!.validate()) {
                // FocusScope.of(context).nextFocus();
                context.read<OtpcheakingCubit>().otpCheaking(int.parse(value));
              }
            },
            hintText: "",
            bodrerRadius: r10,
          ),
        ),
        h20,
        _headingTextSettings("Enter OTP"),
        h5,
        Row(
          children: [
            OtpTextField(
              onSubmit: (value) {
                otp = int.parse(value);
              },
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              margin: EdgeInsets.only(right: 2.w),
              borderWidth: 1,
              // showFieldAsBox: true,
              // autoFocus: true,
              showCursor: false,
              // fieldWidth: 60,
              borderColor: Colors.black,
              enabledBorderColor: Colors.black,
              focusedBorderColor: Colors.black,
              // borderRadius: BorderRadius.circular(30),
              textStyle: const TextStyle(color: Colors.black),
              // hasCustomInputDecoration: true,
            ),
            space,
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: BlocBuilder<OtpresendtimerCubit, OtpresendtimerState>(
                  builder: (context, state) {
                return Visibility(
                  visible:
                      state is OtpresendtimeroncountingFinished ? false : true,
                  replacement: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Resend OTP",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  child: Text(
                      state is OtpresendtimerOncounting
                          ? state.countValue.toString()
                          : "30",
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                );
              }),
            )
          ],
        ),
        h20,
        _buttonForReset(
          text: "Done",
          onPressed: () {
            if (otp != 0) {
              context
                  .read<OtpcheakingCubit>()
                  .otpValidation(int.parse(_phoneController.text), otp);
            }
          },
        ),
      ],
    );
  }

  SizedBox _buttonForReset(
      {required String text, required VoidCallback onPressed}) {
    return SizedBox(
      height: 45,
      width: 350,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(primary: Colors.black),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _passwordReset({required BuildContext context}) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordOnprocess) {
        } else if (state is ResetPasswordOnError) {
        } else if (state is ResetPasswordOnDone) {
          Get.back();
        }
        // TODO: implement listener
      },
      child: Form(
        key: _keyPassword,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            h20,
            Text(
              "Create New Password",
              style: GoogleFonts.lato(
                  fontSize: 28.sp, fontWeight: FontWeight.bold),
            ),
            h20,
            _headingTextSettings("New password"),
            h5,
            TextFieldCustomized(
              controller: _passwordController,
              validator: (password) =>
                  ValidationTextField.passwordValidation(password),
              hintText: "",
              bodrerRadius: r10,
            ),
            h20,
            _headingTextSettings("Confirm Password"),
            h5,
            TextFieldCustomized(
              controller: _confirmPasswordController,
              validator: (password) => ValidationTextField.passwordValidation(
                  password,
                  cheakValue: _passwordController.text),
              hintText: "",
              bodrerRadius: r10,
            ),
            h20,
            SizedBox(
              height: 45,
              width: 350,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.black),
                onPressed: () {
                  if (_keyPassword.currentState!.validate()) {
                    context
                        .read<ResetPasswordCubit>()
                        .resetPassword(_passwordController.text);
                  }
                },
                child: const Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _headingTextSettings(String text) {
    return Text(
      text,
      style: GoogleFonts.lato(fontSize: 13.sp, fontWeight: FontWeight.bold),
    );
  }
}

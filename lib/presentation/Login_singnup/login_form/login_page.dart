import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as GetxNav;
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:road_ster/application/password_visible/paswordvisible_cubit.dart';
import 'package:road_ster/application/user_login/user_login_cubit.dart';
import 'package:road_ster/domain/core/asset_images.dart';
import 'package:road_ster/domain/validations/login_validation.dart';
import 'package:road_ster/presentation/Login_singnup/sign_up_form/sign_up.dart';
import 'package:road_ster/presentation/Login_singnup/login_form/textfieldlogin.dart';

import '../../../domain/core/colors.dart';
import '../../../domain/core/sizedboxes.dart';
import 'heading_text.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PaswordvisibleCubit()),
        BlocProvider(
          create: (context) => UserLoginCubit(),
        )
      ],
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/asset/tDYC1tp.webp"),
                    fit: BoxFit.cover)),
            width: double.infinity,
            height: 270.sp,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 606.727.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                color: colorPalette1,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LoginHeading(),
                    h30,
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.r),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                textfieldLogin(
                                    inputType: TextInputType.emailAddress,
                                    controller: _emailController,
                                    label: "E-mail",
                                    icon: Icon(
                                      Icons.email_outlined,
                                      color: Colors.black,
                                      size: 30.sp,
                                    ),
                                    validator: (value) {
                                      return ValidationTextField.emailValidations(
                                          value);
                                    }),
                                h20,
                                BlocBuilder<PaswordvisibleCubit,
                                    PaswordvisibleState>(
                                  builder: (context, state) {
                                    state as PaswordvisibleInitial;
                                    return textfieldLogin(
                                        controller: _passwordController,
                                        suffix: SuffixIcon(
                                          padding: 10.h,
                                          stateValue: state.initial,
                                            iconData: state.initial
                                                ? Icons.remove_red_eye
                                                : Icons.visibility_off),
                                        visible: state.initial,
                                        label: "Password",
                                        icon: Icon(
                                          Icons.lock_outline_rounded,
                                          color: Colors.black,
                                          size: 30.sp,
                                        ),
                                        validator: (p) =>
                                            ValidationTextField.passwordValidation(
                                                p));
                                  },
                                ),
                                h30,
                                SizedBox(
                                  width: 280.w,
                                  height: 45.h,
                                  child: BlocConsumer<UserLoginCubit,
                                      UserLoginState>(
                                    listener: (context, state) {
                                      if (state is UserLoginOnError) {
                                        GetxNav.Get.snackbar(
                                            "Error", state.message,
                                            colorText: Colors.white,
                                            backgroundColor: Colors.redAccent);
                                      }
                                      if (state is UserLoginOnSucess) {}
                                    },
                                    builder: (context, state) {
                                      return ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.black),
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                            if (_formKey.currentState!
                                                .validate()) {
                                              context
                                                  .read<UserLoginCubit>()
                                                  .loginComing(
                                                      _emailController.text,
                                                      _passwordController.text);
                                            }
                                          },
                                          child: state is UserLoginOnProcess
                                              ? Lottie.asset(
                                                  ImagesStrings.lottieLoading)
                                              : const Text("Login"));
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 150),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Forget password?",
                                        style: GoogleFonts.outfit(
                                            fontWeight: FontWeight.bold,
                                            color: optionalText,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Text(
                                          "Click here",
                                          style: GoogleFonts.outfit(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                              fontSize: 12),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                h30,
                                Text(
                                  "Log in with OTP",
                                  style: GoogleFonts.outfit(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.blue),
                                ),
                                sizedBox80,
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 280.w,
                                  height: 45.h,
                                  child: MaterialButton(
                                      onPressed: () {
                                        GetxNav.Get.to( SignUpForm(),
                                            transition:
                                                GetxNav.Transition.fade);
                                      },
                                      child: const Text(
                                        'Sign up',
                                        style: TextStyle(color: Colors.black),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}

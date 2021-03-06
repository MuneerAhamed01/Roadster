import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_ster/application/splash_screen/splashscreen_cubit.dart';
import 'package:road_ster/domain/core/asset_images.dart';
import 'package:road_ster/domain/core/sizedboxes.dart';
import 'package:road_ster/presentation/Login_singnup/login_form/login_page.dart';
import 'package:road_ster/presentation/splash_screen/splash_texts.dart';
import '../bottom_nav/bottomnavigation_page.dart';
import 'liner_progress_bar.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SplashscreenCubit>().stateCheaking(context);
    return BlocListener<SplashscreenCubit, SplashscreenState>(
      listener: (context, state) async {
        if (state is SplashscreenOnBoard) {
          Get.off(() =>  LoginPage());
        } else if (state is SplashscreenHomePage) {
          await Get.off(() =>   BottomNavigation());
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(children: [
            const SplashScreenText(),
            sizedBox80,
            Align(
              child: ClipRRect(
                clipBehavior: Clip.none,
                child: Image.asset(
                  ImagesStrings.imageSplash,
                ),
              ),
            ),
            sizedBox100,
            const AnimatedProgressBar(),
            sizedBox15,
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Let’s Begin the  Race.....",
                style: GoogleFonts.beVietnamPro(),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

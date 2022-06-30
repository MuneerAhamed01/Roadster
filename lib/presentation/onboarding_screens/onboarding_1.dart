import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../../domain/core/asset_images.dart';
import '../Login_singnup/login_form/login_page.dart';

class OnboardingOne extends StatelessWidget {
  const OnboardingOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: IntroductionScreen(
          globalBackgroundColor: Colors.white,
          showDoneButton: true,
          showNextButton: false,
          done: Text("done"),
          onDone: () {
            Get.off(() => LoginPage());
          },
          pages: [
            onBoardingOne(),
            PageViewModel(
                titleWidget: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 40.w),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        "Roadster Easy and fastest way for Rent car",
                        textAlign: TextAlign.center,
                        textStyle: GoogleFonts.anekMalayalam(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
                body: "",
                image: Padding(
                  padding: EdgeInsets.only(top: 50.h),
                  child: Lottie.asset(ImagesStrings.lotiieOnboardingTwo,
                      repeat: false, height: 300.h),
                ))
          ],
        ));
  }

  PageViewModel onBoardingOne() {
    return PageViewModel(
        titleWidget: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 40.w),
          child: AnimatedTextKit(
            pause: const Duration(milliseconds: 5000),
            animatedTexts: [
              TypewriterAnimatedText(
                "Let's Find the best car for you.",
                textAlign: TextAlign.center,
                textStyle: GoogleFonts.anekMalayalam(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black),
              )
            ],
          ),
        ),
        body: "",
        image: Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: Lottie.asset(ImagesStrings.lottieOnboarding, repeat: false),
        ));
  }
}
//Let's Find Your Favirote\nCar.




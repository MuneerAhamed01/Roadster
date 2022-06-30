import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_ster/domain/core/fonts.dart';

class SplashScreenText extends StatelessWidget {
  const SplashScreenText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, top: 70.h),
      child: Column(
        children: [
          Text(
            "Premium ride \nAffordable price",
            style: GoogleFonts.beVietnamPro(
                fontSize: 35.sp,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                      color: const Color.fromRGBO(0, 0, 0, 200),
                      blurRadius: 10,
                      offset: Offset.fromDirection(13.9, 8))
                ]),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Wide range of luxury cars for hourly rental.\nPrestige cars what nobody can resist.",
            style: beVietnamProOptional,
          )
        ],
      ),
    );
  }
}

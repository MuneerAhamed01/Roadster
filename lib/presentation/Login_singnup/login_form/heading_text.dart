import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_ster/domain/core/colors.dart';

import '../../../domain/core/sizedboxes.dart';

class LoginHeading extends StatelessWidget {
  const LoginHeading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 60.h, left: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Welcome to Roadster",
              style: GoogleFonts.roboto(
                  fontSize: 28.sp, fontWeight: FontWeight.bold)),
          h10,
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Text("Log in to continue",
                style: GoogleFonts.outfit(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: optionalText)),
          ),
        ],
      ),
    );
  }
}

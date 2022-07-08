import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadingHomeText extends StatelessWidget {
  const HeadingHomeText({
    Key? key,
    required this.heading,
  }) : super(key: key);
  final String heading;
  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: GoogleFonts.lato(shadows: [
        Shadow(
            color: const Color.fromRGBO(0, 0, 0, 200),
            blurRadius: 7.8,
            offset: Offset.fromDirection(13.9, 5))
      ], fontSize: 19.sp, fontWeight: FontWeight.bold),
    );
  }
}

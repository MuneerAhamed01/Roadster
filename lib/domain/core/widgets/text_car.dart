import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextForCarName extends StatelessWidget {
  const TextForCarName({
    Key? key,
    required this.carBrand,
    required this.carModel,
    required this.width,
    required this.fontsize, this.textAlign,
  }) : super(key: key);

  final String carBrand;
  final String carModel;
  final double width;
  final double fontsize;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      child: Text(carBrand + carModel,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.lato(
            fontSize: fontsize,
            fontWeight: FontWeight.bold,
          ),
          textAlign:textAlign),
    );
  }
}

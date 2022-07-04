import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/core/colors.dart';

class TextButtonCustomized extends StatelessWidget {
  const TextButtonCustomized({
    Key? key,
    required this.textWithoutButton,
    required this.textWithButton,
    required this.fontSize,
    required this.ontap, required this.color,
  }) : super(key: key);
  final String textWithoutButton;
  final String textWithButton;
  final double fontSize;
  final Function() ontap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          textWithoutButton,
          style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold, color: color, fontSize: fontSize),
        ),
        SizedBox(
          width: 2.w,
        ),
        GestureDetector(
          onTap: ontap,
          child: Text(
            textWithButton,
            style: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: fontSize),
          ),
        )
      ],
    );
  }
}

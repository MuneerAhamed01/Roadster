import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/core/sizedboxes.dart';

class CurouselContainer extends StatelessWidget {
  const CurouselContainer({
    Key? key,
    required this.image,
    required this.headText,
    required this.text,
  }) : super(key: key);
  final String image;
  final String headText;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        color: Colors.black,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20.r),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 240),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              headText,
              style: GoogleFonts.rubik(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            h20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(text,
                  style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}

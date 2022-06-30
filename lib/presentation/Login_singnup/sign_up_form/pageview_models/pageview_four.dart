import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../domain/core/asset_images.dart';
import '../../../../domain/core/colors.dart';

class PageViewModelFour extends StatelessWidget {
  const PageViewModelFour({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              color: Colors.black.withOpacity(0.5),
            ),
            Positioned(
              bottom: -130.h,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 130.r,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 125.r,
                      backgroundImage: const AssetImage(
                          ImagesStrings.profilePicnull),
                    ),
                    Positioned(
                      right: 30,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 150, left: 20, right: 20),
          child: Text(
            'Add a profile Picture for Identify you.If you are not comfortable you can skip it',
            textAlign: TextAlign.center,
            style: GoogleFonts.rubik(
                color: optionalText, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
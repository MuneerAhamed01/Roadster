import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../domain/core/asset_images.dart';
import '../../../domain/core/sizedboxes.dart';

Widget milage = Lottie.asset(ImagesStrings.speedMeter,
    width: 100.w, height: 100.h, repeat: false);
Widget fuelType = Column(
  children: [
    h10,
    Icon(FontAwesomeIcons.gasPump, size: 70.sp, color: Colors.white),
    h10
  ],
);
Widget seats = Column(
  children: [h10, Icon(Icons.chair_alt, size: 70.sp, color: Colors.white), h10],
);

class MilageSub extends StatelessWidget {
  const MilageSub({
    Key? key,
    required this.mileage,
  }) : super(key: key);
  final String mileage;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: mileage,
        style: GoogleFonts.lato(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
        children: const [
          TextSpan(text: " Km/L", style: TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}

class FuelTypeSub extends StatelessWidget {
  const FuelTypeSub({
    Key? key,
    required this.fuelType,
  }) : super(key: key);
  final String fuelType;

  @override
  Widget build(BuildContext context) {
    return Text(
      fuelType,
      style: GoogleFonts.openSans(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 25,
      ),
    );
  }
}

class SeatsSub extends StatelessWidget {
  const SeatsSub({
    Key? key, required this.seats,
  }) : super(key: key);
  final String seats;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: seats,
        style: GoogleFonts.lato(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
        children: const [
          TextSpan(text: " Seats", style: TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}

class SpecificationWidget extends StatelessWidget {
  const SpecificationWidget({
    Key? key,
    this.heading,
    this.subTitle,
  }) : super(key: key);
  final Widget? heading;
  final Widget? subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: 170,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        children: [h15, heading!, subTitle!],
      ),
    );
  }
}

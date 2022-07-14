import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_ster/domain/core/widgets/border_radius.dart';
import 'package:road_ster/domain/models/get_car_details.dart';
import 'package:road_ster/presentation/car_booking_page/car_booking.dart';

import '../../../domain/core/sizedboxes.dart';

class PriceAndBooking extends StatelessWidget {
  const PriceAndBooking({
    Key? key,
    required this.carList, required this.position,
  }) : super(key: key);

  final Datum carList;
  final Position position;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.sp),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Row(
          children: [
            RichText(
              text: TextSpan(
                text: "\$${carList.price}",
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 27),
                children: const [
                  TextSpan(text: " /day", style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            space,
            MaterialButton(
              onPressed: () {
                Get.to(() => CarBookingPage(
                  position: position,
                      carList: carList,
                    ));
              },
              child: Container(
                alignment: Alignment.center,
                width: 130.w,
                height: 40.h,
                decoration:
                    BoxDecoration(color: Colors.white, borderRadius: r10),
                child: Text(
                  "Book Now",
                  style: GoogleFonts.lato(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

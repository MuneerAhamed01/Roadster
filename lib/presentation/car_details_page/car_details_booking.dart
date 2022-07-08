import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:road_ster/domain/core/asset_images.dart';
import 'package:road_ster/domain/core/favirote_button.dart';
import 'package:road_ster/domain/core/widgets/text_car.dart';
import 'package:road_ster/presentation/car_details_page/widget/image_toplayer.dart';
import 'package:road_ster/presentation/car_details_page/widget/specification_section.dart';
import 'package:road_ster/presentation/home_screen/widgets/heading_text.dart';

import '../../domain/core/sizedboxes.dart';

class CarDetailsPage extends StatelessWidget {
  CarDetailsPage({Key? key}) : super(key: key);
  final List heading = [milage, fuelType, seats];
  final List subTitle = const [
    MilageSub(),
    FuelTypeSub(),
    SeatsSub(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        // iconTheme: icond,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ImageInCarDetails(),
          h30,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeadingHomeText(heading: "Description :"),
                h10,
                const Text(
                  "Under the hood, the Z4 sDrive20i is powered by a 2.0-litre inline four-cylinder petrol engine that produces 194bhp of power and 320Nm of torque. The vehicle is capable of sprinting from 0-100kmph in 6.6 seconds",
                  textAlign: TextAlign.justify,
                ),
                h20,
                const HeadingHomeText(heading: "Specifications"),
                h10,
                SizedBox(
                  height: 170,
                  child: ListView.separated(
                    itemBuilder: (context, index) => SpecificationWidget(
                      heading: heading[index],
                      subTitle: subTitle[index]
                    ),
                    separatorBuilder: (context, index) => w10,
                    itemCount: 3,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}


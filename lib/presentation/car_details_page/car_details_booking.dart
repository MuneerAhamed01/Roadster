import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_ster/domain/core/widgets/border_radius.dart';
import 'package:road_ster/domain/models/get_car_details.dart';
import 'package:road_ster/presentation/car_details_page/widget/car_details_body.dart';
import 'package:road_ster/presentation/car_details_page/widget/image_toplayer.dart';
import 'package:road_ster/presentation/car_details_page/widget/price_booking.dart';
import 'package:road_ster/presentation/car_details_page/widget/specification_section.dart';
import 'package:road_ster/presentation/home_screen/widgets/heading_text.dart';

import '../../domain/core/sizedboxes.dart';
import '../../domain/core/widgets/location_radius.dart';

class CarDetailsPage extends StatelessWidget {
  CarDetailsPage({Key? key, required this.carList, required this.position})
      : super(key: key);
  final Datum carList;
  final List heading = [milage, fuelType, seats];
  final Position position;

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
      body: CarDetailsBody(
        heading: heading,
        carList: carList,
        position: position,
      ),
      bottomNavigationBar: PriceAndBooking(carList: carList,position: position),
    );
  }
}


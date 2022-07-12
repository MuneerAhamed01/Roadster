import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:road_ster/domain/core/available_date.dart';
import 'package:road_ster/domain/core/widgets/border_radius.dart';
import 'package:road_ster/domain/core/widgets/text_car.dart';

import '../../domain/core/sizedboxes.dart';

class CarBookingPage extends StatelessWidget {
  const CarBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const DatePickContainer(name: "Muneer"),
              h20,
              Container(
                alignment: Alignment.topCenter,
                height: 400.h,
                width: double.infinity,
                decoration:
                    BoxDecoration(color: Colors.white, borderRadius: r10),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextForCarName(
                        carBrand: "FerrariF8",
                        carModel: "Tributo",
                        width: double.infinity,
                        fontsize: 30.sp),
                    Column(
                      children: [
                        Text("data"),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

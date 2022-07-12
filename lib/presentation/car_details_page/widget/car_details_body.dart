import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_ster/domain/core/widgets/border_radius.dart';
import 'package:road_ster/domain/models/get_car_details.dart';
import 'package:road_ster/presentation/car_details_page/widget/image_toplayer.dart';
import 'package:road_ster/presentation/car_details_page/widget/specification_section.dart';
import 'package:road_ster/presentation/home_screen/widgets/heading_text.dart';
import '../../../domain/core/sizedboxes.dart';
import '../../../domain/core/widgets/location_radius.dart';

class CarDetailsBody extends StatelessWidget {
  final TextEditingController _reviewController = TextEditingController();
  CarDetailsBody({
    Key? key,
    required this.heading,
    required this.carList,
    required this.position,
  }) : super(key: key);

  final List heading;
  final Position position;
  final Datum carList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageInCarDetails(carList: carList),
              h30,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeadingHomeText(heading: "Description :"),
                    h10,
                    Text(
                      carList.description,
                      textAlign: TextAlign.justify,
                    ),
                    h20,
                    const HeadingHomeText(heading: "Specifications"),
                    h10,
                    SizedBox(
                      height: 170,
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final List subTitle = [
                            MilageSub(mileage: carList.mileage),
                            FuelTypeSub(
                                fuelType: carList.fueltype == Fueltype.DIESEL
                                    ? "Diesel"
                                    : "Petrol"),
                            SeatsSub(seats: carList.seats.toString()),
                          ];
                          return SpecificationWidget(
                              heading: heading[index],
                              subTitle: subTitle[index]);
                        },
                        separatorBuilder: (context, index) => w10,
                        itemCount: 3,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    h10,
                    Row(
                      children: [
                        const HeadingHomeText(heading: 'Location'),
                        space,
                        KiloMeterView(
                          carList: carList,
                          position: position,
                        )
                      ],
                    ),
                    h10,
                    Container(
                      alignment: Alignment.center,
                      height: 50.h,
                      width: double.infinity,
                      decoration:
                          BoxDecoration(color: Colors.white, borderRadius: r10),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.locationPinLock,
                              size: 20.sp,
                              color: Colors.red,
                            ),
                            space,
                            Text(carList.location)
                          ],
                        ),
                      ),
                    ),
                    h10,
                    Row(
                      children: [
                        SizedBox(
                            width: 265.w,
                            child: TextField(
                              controller: _reviewController,
                            )),
                        w10,
                        ElevatedButton(
                          onPressed: () {
                            print(_reviewController.text);
                          },
                          style: ElevatedButton.styleFrom(
                              onSurface: Colors.black, primary: Colors.black),
                          child: const Text("Submit"),
                        )
                      ],
                    ),
                    h10
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

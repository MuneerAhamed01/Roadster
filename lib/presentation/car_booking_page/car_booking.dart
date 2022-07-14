import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:road_ster/application/car_details/car_details_bloc.dart';
import 'package:road_ster/domain/core/available_date.dart';
import 'package:road_ster/domain/core/colors.dart';
import 'package:road_ster/domain/core/list_for_carousel.dart';
import 'package:road_ster/domain/core/widgets/border_radius.dart';
import 'package:road_ster/domain/core/widgets/text_car.dart';
import 'package:road_ster/domain/models/user_login.dart';

import '../../domain/core/sizedboxes.dart';
import '../../domain/models/get_car_details.dart';
import '../../main.dart';

class CarBookingPage extends StatelessWidget {
  CarBookingPage({Key? key, required this.carList, required this.position})
      : super(key: key);
  final Datum carList;
  final Position position;
  static final response = preferences.getString("userData");

  static LoginDetails getResponseFromJson() => loginDetailsFromJson(response!);

  final list = getResponseFromJson();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                DatePickContainer(
                  name: list.name,
                  type: HomeOrBooking.booking,
                ),
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
                      h15,
                      TextForCarName(
                          carBrand: carList.brand,
                          carModel: carList.model,
                          width: double.infinity,
                          textAlign: TextAlign.center,
                          fontsize: 30.sp),
                      h5,
                      const Divider(
                        color: Colors.black87,
                      ),
                      h10,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            _textFordetails(
                                customerDetail: list.name, detail: "Name"),
                            h20,
                            _textFordetails(
                                detail: "Start On",
                                customerDetail: "28-07-2020"),
                            h20,
                            _textFordetails(
                                detail: "Ends On",
                                customerDetail: "28-07-2020"),
                            h20,
                            _textFordetails(
                                detail: "Days", customerDetail: "3"),
                            h20,
                            _textFordetails(
                                detail: "From",
                                customerDetail: currrentDistrict)
                          ],
                        ),
                      ),
                      h10,
                      const Divider(color: Colors.black),
                      h20,
                      _textForPrice(detail: "Per Day", customerDetail: "\$300"),
                      h15,
                      _textForPrice(detail: "Discount", customerDetail: "\$0"),
                      h15,
                      _textForPrice(detail: "Total", customerDetail: "\$300"),
                    ],
                  ),
                ),
                h10,
                TextButton(
                    onPressed: () {}, child: Text("Add the coupun You have")),
                _containerPriceButton(
                    color: Colors.green, onPressed: () {}, text: "Pay"),
                h10,
                _containerPriceButton(
                    color: Colors.red, onPressed: () {}, text: "Cancel")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _containerPriceButton(
      {required Color color,
      required void Function()? onPressed,
      required String text}) {
    return Container(
      width: double.infinity,
      height: 45.h,
      decoration:
          BoxDecoration(border: Border.all(color: color), borderRadius: r10),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }

  Row _textFordetails(
      {required String detail, required String customerDetail}) {
    return Row(
      children: [
        Text(
          "$detail :",
          style: const TextStyle(color: optionalText),
        ),
        space,
        Text(customerDetail)
      ],
    );
  }

  Widget _textForPrice(
      {required String detail, required String customerDetail}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Text(
            "$detail :",
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          space,
          Text(customerDetail)
        ],
      ),
    );
  }
}

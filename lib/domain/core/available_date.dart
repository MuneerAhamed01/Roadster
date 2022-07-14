import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:road_ster/application/car_details/car_details_bloc.dart';
import 'package:road_ster/application/date_picking_car/date_picking_cubit.dart';
import 'package:road_ster/domain/api_values/api.dart';
import 'package:road_ster/domain/core/list_for_carousel.dart';
import 'package:road_ster/domain/core/sizedboxes.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:road_ster/domain/models/available_districts.dart';

class DateContainer extends StatelessWidget {
  const DateContainer({
    Key? key,
    required this.text,
    required this.ontap,
  }) : super(key: key);
  final String text;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 140,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 1, 77, 175),
                  blurRadius: 1,
                  spreadRadius: 0.4)
            ]),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(text),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                FontAwesomeIcons.calendarDay,
                color: Colors.blue[300],
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}

//This is the main container..........

class DatePickContainer extends StatelessWidget {
  const DatePickContainer({
    Key? key,
    required this.name,
    required this.type,
  }) : super(key: key);
  final String name;
  final HomeOrBooking type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: type == HomeOrBooking.booking ? null : 350.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type == HomeOrBooking.booking
                  ? "Confirm Your Details  $name..."
                  : "Hello $name....",
              style: GoogleFonts.openSans(
                  fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            h10,
            Text(
              type == HomeOrBooking.booking
                  ? "Comfirm the date and location of your journey.Have a nice Trip......🤗"
                  : "Choose the date and location we can show the available items",
              style: GoogleFonts.outfit(),
            ),
            h20,
            BlocConsumer<DatePickingCubit, DatePickingState>(
              listener: (context, state) {
                if (state is DatePickingDone) {
                  context
                      .read<CarDetailsBloc>()
                      .add(CarGetDetailDatePicking(state.dateTimeRange));
                }
              },
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DateContainer(
                        ontap: () {
                          context
                              .read<DatePickingCubit>()
                              .pickDateTimeRange(context);
                        },
                        text: state is DatePickingDone
                            ? DateFormat("dd-MM-yyyy")
                                .format(state.dateTimeRange.start)
                            : "From"),
                    DateContainer(
                        ontap: () {},
                        text: state is DatePickingDone
                            ? DateFormat("dd-MM-yyyy")
                                .format(state.dateTimeRange.end)
                            : "To"),
                  ],
                );
              },
            ),
            h20,
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: FindDropdown(
                selectedItem: currrentDistrict,
                onFind: (text) async {
                  var response = await Dio()
                      .get(ApiValues.baseUrl + ApiValues.districtData);
                  final districts = GetDistrictDetails.fromJson(response.data);

                  return districts.getdistrict.map((e) => e.district).toList();
                },
                onChanged: (value) {
                  print(value);
                },
                showSearchBox: false,
                dropdownBuilder: (context, value) => _dropDownButton(value),
              ),
            ),
            if (type == HomeOrBooking.home) h20,
            if (type == HomeOrBooking.home)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue[300]),
                  child: MaterialButton(
                    onPressed: () {
                      // if(state is )
                      // context.read<SubjectBloc>()
                      Get.back();
                    },
                    child: const Text(
                      "Done",
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Container _dropDownButton(Object? value) {
    return Container(
      alignment: Alignment.centerLeft.add(const Alignment(0.1, 0)),
      height: 40,
      width: 293,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 1, 77, 175),
                blurRadius: 1,
                spreadRadius: 0.4)
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          children: [
            Text(value.toString()),
            space,
            const Icon(Icons.arrow_drop_down)
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_ster/domain/core/sizedboxes.dart';

import '../../domain/core/available_date.dart';

class WatchlistCar extends StatelessWidget {
  const WatchlistCar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: BookingCheakDate(),
        ),
      ),
    );
  }
}

class BookingCheakDate extends StatelessWidget {
  const BookingCheakDate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: DatePickContainer(
        name: "MUnerr",
      ),
    );
  }
}

class DatePickContainer extends StatelessWidget {
  const DatePickContainer({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
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
                "HAI $name...",
                style: GoogleFonts.openSans(
                    fontSize: 25.sp, fontWeight: FontWeight.bold),
              ),
              h10,
              Text(
                "Tell us when your Ride starts.It's helpful to show you the Available items",
                style: GoogleFonts.outfit(),
              ),
              h20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DateContainer(ontap: () {}, text: "From"),
                  DateContainer(ontap: () {}, text: "To"),
                ],
              ),
              h30,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue[300]),
                    child: MaterialButton(
                        onPressed: () {},
                        child: const Text(
                          "Done",
                        ))),
              )
            ],
          ),
        ));
  }
}

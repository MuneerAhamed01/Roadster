import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_ster/domain/core/sizedboxes.dart';

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

class DatePickContainer extends StatelessWidget {
  const DatePickContainer({
    Key? key,
  }) : super(key: key);

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
                "Hai Muneer...",
                style: GoogleFonts.roboto(
                    fontSize: 30.sp, fontWeight: FontWeight.bold),
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
              )
            ],
          ),
        ));
  }
}

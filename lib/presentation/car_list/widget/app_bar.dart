import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../application/car_details/car_details_bloc.dart';
import '../../../domain/core/colors.dart';

class AppBarCustomized extends StatelessWidget {
  const AppBarCustomized({Key? key, required this.suffixIcon}) : super(key: key);
  final Widget suffixIcon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TextField(
        cursorColor: Colors.black,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: const Icon(
              Icons.search,
              size: 23,
              color: Colors.black,
            ),
            border: _outlineBorder(),
            focusedBorder: _outlineBorder(),
            enabledBorder: _outlineBorder(),
            filled: true,
            fillColor: colorPalette2,
            hintText: "Search by the car name",
            contentPadding: const EdgeInsets.only(
              top: 5,
              left: 15,
            ),
            hintStyle: GoogleFonts.lato(fontSize: 15)),
        onChanged: (value) {
          context.read<CarDetailsBloc>().add(CarGetDetailsBySearch(value));
        },
      ),
    );
  }

  OutlineInputBorder _outlineBorder() {
    return const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent));
  }
}

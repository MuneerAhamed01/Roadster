import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/core/colors.dart';

class AppBarCustomized extends StatelessWidget {
  const AppBarCustomized(
      {Key? key, required this.suffixIcon, required this.onChanged})
      : super(key: key);
  final Widget suffixIcon;
  final void Function(String)? onChanged;

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
        onChanged: onChanged,
      ),
    );
  }

  OutlineInputBorder _outlineBorder() {
    return const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent));
  }
}

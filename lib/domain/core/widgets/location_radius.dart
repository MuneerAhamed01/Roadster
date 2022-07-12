import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/get_car_details.dart';
import '../car_list_by_km.dart';

class KiloMeterView extends StatelessWidget {
  const KiloMeterView({
    Key? key,
     this.carList,
     this.position,
  }) : super(key: key);

  final Datum? carList;
  final Position? position;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 20,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.20),
              blurRadius: 2,
              blurStyle: BlurStyle.normal,
            )
          ],
          borderRadius: BorderRadius.circular(5)),
      child: Text(
      "${carListKm(carList!, position!)}Km",
        style: GoogleFonts.outfit(color: Colors.black, fontSize: 8),
      ),
    );
  }
}
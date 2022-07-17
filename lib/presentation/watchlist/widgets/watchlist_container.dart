import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/core/asset_images.dart';
import '../../../domain/core/colors.dart';
import '../../../domain/core/favirote_button.dart';
import '../../../domain/core/sizedboxes.dart';
import '../../../domain/core/widgets/text_car.dart';
import '../../../domain/models/get_car_details.dart';
import '../../car_details_page/car_details_booking.dart';

class WatchListContainer extends StatelessWidget {
  const WatchListContainer({
    Key? key,
    required this.carList,
    required this.position,
    required this.isWachList, required this.index,
  }) : super(key: key);
  final Datum carList;
  final Position position;
  final List<String> isWachList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => CarDetailsPage(
            isWachList: isWachList,
            carList: carList,
            position: position,
          )),
      child: Container(
        height: 200.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Row(
          children: [
            Container(
              // alignment: Alignment.topLeft,
              height: 200.h,
              width: 170,
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    image: NetworkImage(carList.imgUrl), fit: BoxFit.contain),
              ),
              child: IconOfDelete(
                index: index,
                carBrand: carList.brand,
                isWatchList: isWachList.contains(carList.id),
                carid: carList.id,
                imageName: "imageName",
                align: Alignment.topLeft.add(const Alignment(0.2, 0)),
              ),
            ),
            w20,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                h20,
                TextForCarName(
                  carBrand: carList.brand,
                  carModel: carList.model,
                  fontsize: 18,
                  width: 171,
                ),
                h5,
                Text("Place : ${carList.location}",
                    style: GoogleFonts.lato(color: optionalText, fontSize: 10)),
                h10,
                SizedBox(
                  width: 160.w,
                  child: Text(
                    carList.description,
                    style: TextStyle(
                      fontSize: 10.sp,
                      overflow: TextOverflow.clip,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_ster/domain/core/car_list_by_km.dart';
import 'package:road_ster/domain/core/sizedboxes.dart';
import 'package:road_ster/domain/core/widgets/location_radius.dart';
import 'package:road_ster/domain/core/widgets/text_car.dart';
import 'package:road_ster/domain/models/get_car_details.dart';

import '../../presentation/car_details_page/car_details_booking.dart';
import 'asset_images.dart';
import 'favirote_button.dart';

class CarContainer extends StatelessWidget {
  const CarContainer({
    Key? key,
    this.carList,
    this.index,
    required this.position, required this.isWachList,
    
  }) : super(key: key);
  final Datum? carList;
  final int? index;
  final Position position;
  final List<String> isWachList;

  @override
  Widget build(BuildContext context) {
    // print(isWachList);
    return GestureDetector(
      onTap: ()=>Get.to(()=>CarDetailsPage(carList: carList!,position: position,)),
      child: Container(
        height: 240.h,
        width: 200.w,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(carList!.imgUrl),
                        fit: BoxFit.contain,
                      ),
                      borderRadius: BorderRadius.circular(10.r)),
                  width: 200.w,
                  height: 160.h,
                ),
                IconOfDelete(
                    isWatchList: isWachList.contains(carList!.id),
                    carid: carList!.id,
                    carBrand: carList!.brand,
                    imageName: "imageName",
                    align: Alignment.topRight.add(const Alignment(-0.1, 0))),
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: KiloMeterView(carList: carList, position: position),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: TextForCarName(
                  carBrand: carList!.brand,
                  carModel: carList!.model,
                  fontsize: 16,
                  width: 200),
            ),
            h20,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${carList!.price}/day",
                    style: GoogleFonts.openSans(
                        fontSize: 14.sp,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    width: 70.w,
                    height: 27.h,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5.r)),
                    child: MaterialButton(
                      onPressed: () {
                        print("NAlla car ann vangikko");
                      },
                      child: Text(
                        "Book Now",
                        style: GoogleFonts.lato(
                          fontSize: 8.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            h10
          ],
        ),
      ),
    );
  }
}



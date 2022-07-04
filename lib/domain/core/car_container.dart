import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_ster/domain/core/sizedboxes.dart';
import 'package:road_ster/domain/models/get_car_details.dart';

import 'asset_images.dart';
import 'favirote_button.dart';

class CarContainer extends StatelessWidget {
  const CarContainer({
    Key? key,
    this.carList,
    this.index,
  }) : super(key: key);
  final List<Datum>? carList;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      image: NetworkImage(carList![index!].imgUrl),
                      fit: BoxFit.contain,
                    ),
                    borderRadius: BorderRadius.circular(10.r)),
                width: 200.w,
                height: 160.h,
              ),
              const IconOfDelete(id: "", imageName: "imageName")
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: SizedBox(
              width: 200.w,
              child: Text(
                carList![index!].brand + carList![index!].model,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          h20,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${carList![index!].price}/day",
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
    );
  }
}

class CarContainerOne extends StatelessWidget {
  const CarContainerOne({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      image: AssetImage(ImagesStrings.carImageTwo),
                      fit: BoxFit.contain,
                    ),
                    borderRadius: BorderRadius.circular(10.r)),
                width: 200.w,
                height: 160.h,
              ),
              const IconOfDelete(id: "", imageName: "imageName")
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 18.w),
            child: Text(
              "jlksdfjlkdfsa",
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          h20,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$350/day",
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
                      Get.bottomSheet(Container(
                        height: 500,
                        width: double.infinity,
                        color: Colors.white,
                        child: Text("data"),
                      ));
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
          )
        ],
      ),
    );
  }
}

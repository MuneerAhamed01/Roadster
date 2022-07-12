import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:road_ster/domain/models/get_car_details.dart';

import '../../../domain/core/asset_images.dart';
import '../../../domain/core/favirote_button.dart';
import '../../../domain/core/widgets/text_car.dart';

class ImageInCarDetails extends StatelessWidget {
  const ImageInCarDetails({
    Key? key,
    required this.carList,
  }) : super(key: key);
  final Datum carList;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      height: 360.h,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(55.r)),
          image: DecorationImage(
              image: NetworkImage(carList.imgUrl), fit: BoxFit.contain)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 7.h),
              child: TextForCarName(
                  carBrand: carList.brand,
                  carModel: " ${carList.model}",
                  width: 280,
                  fontsize: 30),
            ),
            const Spacer(),
            IconOfDelete(
                radius: 20.r,
                carid: carList.id,
                imageName: "imageName",
                align: Alignment.topLeft.add(const Alignment(0, -0.02)),
                isWatchList: false,
                carBrand: "carBrand")
          ],
        ),
      ),
    );
  }
}

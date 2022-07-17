import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_ster/domain/core/colors.dart';

class CustomizedBackButton extends StatelessWidget {
  const CustomizedBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, top: 20.h),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              radius: 19,
              backgroundColor: Colors.black.withOpacity(0.5),
              child: CircleAvatar(
                backgroundColor: backgroundColor,
                radius: 18,
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 16.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ));
  }
}

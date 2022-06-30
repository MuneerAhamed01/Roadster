import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/core/colors.dart';

class AnimatedProgressBar extends StatelessWidget {
  const AnimatedProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      child: SizedBox(
        height: 28.h,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          child: TweenAnimationBuilder(
            tween: Tween(begin: 0.01, end: 1.0),
            duration: const Duration(seconds: 2),
            builder: (context, double value, _) {
              return LinearProgressIndicator(
                  backgroundColor: indicatorBackground,
                  value: value,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.white));
            },
          ),
        ),
      ),
    );
  }
}

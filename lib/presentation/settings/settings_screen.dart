import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_ster/application/user_details_settings/get_userdetail_and_image_bloc.dart';
import 'package:road_ster/domain/core/asset_images.dart';
import 'package:road_ster/domain/core/colors.dart';
import 'package:road_ster/domain/core/shimmer.dart';
import 'package:road_ster/main.dart';
import 'package:road_ster/presentation/Login_singnup/login_form/login_page.dart';
import 'package:road_ster/presentation/settings/screens/booking_histroy/booking_history.dart';
import 'package:road_ster/presentation/settings/screens/reset_password/reset_password.dart';
import 'package:road_ster/presentation/settings/screens/user_account_details/update_profile.dart';

import '../../domain/core/sizedboxes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetUserdetailAndImageBloc>(
      create: (context) =>
          GetUserdetailAndImageBloc()..add(GetDetailsSettings()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: BlocBuilder<GetUserdetailAndImageBloc,
                GetUserdetailAndImageState>(
              builder: (context, state) {
                return Column(
                  children: [
                    h50,
                    SafeArea(
                      child: SizedBox(
                        // alignment: Alignment.topCenter,
                        width: double.infinity,
                        height: 140.h,
                        // color: optionalText,
                        child: state is GetUserdetailAndImageOnDone
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  state.imageUrl!.isEmpty ||
                                          state.imageUrl == null
                                      ? CircleAvatar(
                                          radius: 50.r,
                                          backgroundImage: const AssetImage(
                                              ImagesStrings.profilePicnull),
                                        )
                                      : CircleAvatar(
                                          radius: 50.r,
                                          backgroundImage: NetworkImage(
                                            state.imageUrl!,
                                          ),
                                        ),
                                  w20,
                                  Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 19.h),
                                        child: Text(
                                          state.usersDetails.name,
                                          style: GoogleFonts.lato(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.sp),
                                        ),
                                      ),
                                      h10,
                                      Text(
                                        state.usersDetails.district,
                                        style: const TextStyle(
                                            color: optionalText),
                                      )
                                    ],
                                  )
                                ],
                              )
                            : _shimmerSettings(),
                      ),
                    ),
                    h40,
                    Column(
                      children: [
                        _settingsList(
                            onTap: () => state is GetUserdetailAndImageOnDone
                                ? Get.to(ProfileUpdate(
                                    image: state.imageUrl!,
                                    userData: state.usersDetails,
                                  ))!
                                    .then((value) => context
                                        .read<GetUserdetailAndImageBloc>()
                                        .add(GetDetailsSettings()))
                                : null,
                            icon: FontAwesomeIcons.user,
                            name: "My Account"),
                        h50,
                        _settingsList(
                            onTap: () => Get.to(const BookingHistory()),
                            icon: FontAwesomeIcons.file,
                            name: "Booking History"),
                        h50,
                        _settingsList(
                            icon: FontAwesomeIcons.message,
                            name: "Help and Support"),
                        h50,
                        _settingsList(
                          onTap: () {
                            state is GetUserdetailAndImageOnDone
                                ? Get.to(ResetPassword())!.then((value) {
                                    Get.snackbar("Password Reset",
                                        "Password reset sucessfully");
                                  })
                                : null;
                          },
                          icon: FontAwesomeIcons.lock,
                          name: "Reset Password",
                        ),
                        h50,
                        _settingsList(
                            onTap: () async {
                              await preferences.remove("userData");
                              Get.offAll(LoginPage());
                            },
                            icon: FontAwesomeIcons.arrowRightFromBracket,
                            name: "Log out")
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Row _shimmerSettings() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // CircleAvatar(
        //   radius: 50.r,
        //   backgroundImage: const AssetImage(
        //       ImagesStrings.profilePicnull),
        // ),
        ShimmerWidget(
          width: 100.w,
          height: 100.h,
          shape: BoxShape.circle,
        ),
        w20,
        Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 19.h),
                child: ShimmerWidget(width: 200.w, height: 20.h)),
            h10,
            ShimmerWidget(width: 130.w, height: 20.h)
          ],
        )
      ],
    );
  }

  GestureDetector _settingsList(
      {required IconData icon, required String name, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: Color.fromARGB(255, 228, 238, 243),
            child: Icon(
              icon,
              size: 15,
            ),
          ),
          w30,
          Text(
            name,
            style: GoogleFonts.dmSans(),
          )
        ],
      ),
    );
  }
}

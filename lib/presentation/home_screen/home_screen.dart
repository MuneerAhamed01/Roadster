import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_ster/domain/core/asset_images.dart';
import 'package:road_ster/domain/core/colors.dart';
import 'package:road_ster/domain/core/shimmer.dart';
import 'package:road_ster/domain/core/sizedboxes.dart';
import 'package:road_ster/domain/models/user_login.dart';
import 'package:road_ster/main.dart';
import 'package:road_ster/presentation/home_screen/widgets/carosel.dart';
import 'package:road_ster/presentation/home_screen/widgets/cursoal_container.dart';
import 'package:road_ster/presentation/home_screen/widgets/heading_text.dart';
import 'package:road_ster/presentation/watchlist/watchlist.dart';

import '../../application/car_details/car_details_bloc.dart';
import '../../domain/core/car_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bloc = CarDetailsBloc();
  final String? response = preferences.getString("userData");
  late LoginDetails  userDetals;
  @override
  void initState() {
    userDetals = loginDetailsFromJson(response!);
    _bloc.add(CarGetDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocProvider(
        create: (_) => _bloc,
        child: BlocBuilder<CarDetailsBloc, CarDetailsState>(
            builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    const CostomizedCarousel(),
                    SafeArea(
                        child: Padding(
                      padding: EdgeInsets.only(right: 20.w, top: 10.h),
                      child: GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                               Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 20.h),
                                child: DatePickContainer(
                                  name:userDetals.name,
                                ),
                              ),
                              isDismissible: false);
                          preferences.setBool("isShowen", true);
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.location_history,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
                h50,
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: const HeadingHomeText(heading: "Nearby Me"),
                ),
                h20,
                ListOfCars(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => w10,
                    itemBuilder: (context, index) => state is CarDetailsDone
                        ? CarContainer(
                            carList: state.carListByNearBy,
                            index: index,
                          )
                        : ShimmerWidget(width: 200, height: 200),
                    itemCount: state is CarDetailsDone
                        ? state.carListByNearBy.length
                        : 5,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                  ),
                ),
                h20,
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: const HeadingHomeText(heading: "Top picks"),
                ),
                h20,
                ListOfCars(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => w10,
                    itemBuilder: (context, index) => state is CarDetailsDone
                        ? CarContainer(
                            carList: state.carListByTopPick,
                            index: index,
                          )
                        : ShimmerWidget(width: 200, height: 200),
                    itemCount: state is CarDetailsDone
                        ? state.carListByTopPick.length
                        : 5,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                  ),
                ),
                h20
              ],
            ),
          );
        }),
      ),
    );
  }
}

class ListOfCars extends StatelessWidget {
  const ListOfCars({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SizedBox(height: 240, child: child),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:road_ster/application/car_details/car_details_bloc.dart';
import 'package:road_ster/domain/core/car_container.dart';
import 'package:road_ster/domain/core/colors.dart';
import 'package:road_ster/domain/core/shimmer.dart';
import 'package:road_ster/domain/core/sizedboxes.dart';
import 'package:road_ster/presentation/car_list/widget/app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CarListed extends StatefulWidget {
  const CarListed({Key? key}) : super(key: key);

  @override
  State<CarListed> createState() => _CarListedState();
}

class _CarListedState extends State<CarListed> {
  final CarDetailsBloc _bloc = CarDetailsBloc();
  @override
  void initState() {
    _bloc.add(CarGetDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(50.w, 60.h),
              child: const AppBarCustomized(),
            ),
            body: BlocBuilder<CarDetailsBloc, CarDetailsState>(
                builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          h10,
                          GridView.builder(
                            controller: ScrollController(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 9,
                              mainAxisExtent: 240,
                              crossAxisSpacing: 9,
                            ),
                            itemBuilder: (context, index) => state
                                    is CarDetailsDone
                                ? CarContainer(
                                    carList: state.carListByKM,
                                    index: index,
                                  )
                                : const ShimmerWidget(width: 200, height: 240),
                            shrinkWrap: true,
                            itemCount: state is CarDetailsDone
                                ? state.carListByKM.length
                                : 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 2),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorPalette2,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Above",
                            style: TextStyle(
                                fontSize: 7.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "20Km",
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
          );
        },
      ),
    );
  }
}

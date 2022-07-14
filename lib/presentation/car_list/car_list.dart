import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:road_ster/application/car_details/car_details_bloc.dart';
import 'package:road_ster/application/get_watchlist_data/get_watchlist_data_bloc.dart';
import 'package:road_ster/domain/core/car_container.dart';
import 'package:road_ster/domain/core/colors.dart';
import 'package:road_ster/domain/core/shimmer.dart';
import 'package:road_ster/domain/core/sizedboxes.dart';
import 'package:road_ster/presentation/car_list/widget/app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/models/get_car_details.dart';

class CarListed extends StatefulWidget {
  const CarListed({Key? key}) : super(key: key);

  @override
  State<CarListed> createState() => _CarListedState();
}

class _CarListedState extends State<CarListed> {
  final scrollcontroller = ScrollController();
  // final CarDetailsBloc _bloc = CarDetailsBloc();

  final GetWatchlistDataBloc _getWatchlistDataBloc = GetWatchlistDataBloc();
  @override
  void initState() {
    // _bloc.add(CarGetDetailsCarList());
    _getWatchlistDataBloc.add(GetWatchListIstrue());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (_) => _bloc),
        BlocProvider(create: (_) => _getWatchlistDataBloc)
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(50.w, 60.h),
              child: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                child: AppBarCustomized(
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      FontAwesomeIcons.filter,
                      size: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            body: BlocBuilder<CarDetailsBloc, CarDetailsState>(
                builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      h10,
                      state is CarDetailsSearchEmpty
                          ? Padding(
                              padding: EdgeInsets.only(top: 100.h),
                              child: const Center(
                                child: Text("Sorry No data found😥😥"),
                              ),
                            )
                          : BlocBuilder<GetWatchlistDataBloc,
                              GetWatchlistDataState>(
                              builder: (context, stateWatch) {
                                
                                return GridView.builder(
                                  controller: scrollcontroller,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 9,
                                    mainAxisExtent: 240,
                                    crossAxisSpacing: 9,
                                  ),
                                  itemBuilder: (context, index) {
                                    if (state is CarDetailsDone && stateWatch is GetWatchlistDataGetDone) {
                                      return CarContainer(
                                                                                isWachList: stateWatch.ids! ,

                                        position: state.currentPosition,
                                        carList: state.carListByKM![index],
                                        index: index,
                                      );
                                    } else if (state is CarDetailsSearch && stateWatch is GetWatchlistDataGetDone) {
                                      return CarContainer(
                                        isWachList: stateWatch.ids! ,
                                        position: state.currentPosition,
                                        carList: state.list[index],
                                        index: index,
                                      );
                                    } else {
                                      return ShimmerWidget(
                                          width: 200.w, height: 240.h);
                                    }
                                  },
                                  shrinkWrap: true,
                                  itemCount: state is CarDetailsDone
                                      ? state.carListByKM!.length
                                      : state is CarDetailsSearch
                                          ? state.list.length
                                          : 7,
                                );
                              },
                            ),
                    ],
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

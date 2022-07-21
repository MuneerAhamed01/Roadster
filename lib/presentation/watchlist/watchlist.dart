import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_ster/application/get_watchlist_data/get_watchlist_data_bloc.dart';
import 'package:road_ster/application/watchlist_search/search_view_watch_cubit.dart';
import 'package:road_ster/domain/core/colors.dart';
import 'package:road_ster/domain/core/shimmer.dart';
import 'package:road_ster/domain/core/sizedboxes.dart';
import 'package:road_ster/presentation/watchlist/widgets/watchlist_container.dart';
import '../car_list/widget/app_bar.dart';

final itemListKey = GlobalKey<AnimatedListState>();

class WatchlistCar extends StatefulWidget {
  const WatchlistCar({Key? key}) : super(key: key);

  @override
  State<WatchlistCar> createState() => _WatchlistCarState();
}

class _WatchlistCarState extends State<WatchlistCar> {
  final _bloc = GetWatchlistDataBloc();

  @override
  void initState() {
    _bloc.add(GetWatchListData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _bloc.add(GetWatchListData());
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchViewWatchCubit()),
        BlocProvider(create: (_) => _bloc),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: BlocBuilder<SearchViewWatchCubit, SearchViewWatchState>(
              builder: (context, state) {
                state as SearchViewWatchOnPressed;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      h10,
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Row(
                          children: [
                            Text(
                              "Your Watchlist",
                              style: GoogleFonts.openSans(
                                  color: textColorBrown,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Visibility(
                              visible: !state.onPressed,
                              child: IconButton(
                                  onPressed: () {
                                    context
                                        .read<SearchViewWatchCubit>()
                                        .onPressed(state.onPressed);
                                  },
                                  icon: const Icon(
                                    Icons.search,
                                    color: textColorBrown,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: state.onPressed,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: AppBarCustomized(
                            onChanged: (value) {
                              context
                                  .read<GetWatchlistDataBloc>()
                                  .add(GetWatchListBySearch(value));
                            },
                            suffixIcon: IconButton(
                              onPressed: () {
                                context
                                    .read<SearchViewWatchCubit>()
                                    .onPressed(state.onPressed);
                              },
                              icon: const Icon(
                                FontAwesomeIcons.xmark,
                                size: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      h15,
                      BlocBuilder<GetWatchlistDataBloc, GetWatchlistDataState>(
                        builder: (context, stateCar) {
                          if (stateCar is GetWatchlistDataGetDone) {
                            if (stateCar.carList!.isEmpty) {
                              return Padding(
                                padding: EdgeInsets.only(top: 300.h),
                                child: const Center(
                                  child: Text("No Data available"),
                                ),
                              );
                            }
                            return AnimatedList(
                              key: itemListKey,

                              controller: ScrollController(),
                              itemBuilder: (context, index, animation) =>
                                  Column(
                                children: [
                                  WatchListContainer(
                                    index: index,
                                    isWachList: stateCar.ids!,
                                    position: stateCar.position,
                                    carList: stateCar.carList![index],
                                  ),
                                  h10
                                ],
                              ),
                              shrinkWrap: true,
                              initialItemCount: stateCar.carList!.length,
                              // separatorBuilder: (context, index) => h10,
                            );
                          } else {
                            return ListView.separated(
                              controller: ScrollController(),
                              itemBuilder: (context, index) => ShimmerWidget(
                                  width: double.infinity, height: 200.h),
                              shrinkWrap: true,
                              itemCount: 5,
                              separatorBuilder: (context, index) => h10,
                            );
                          }
                        },
                      ),
                      h10
                    ],
                  ),
                );
              },
            ),
          )),
        ),
      ),
    );
  }
}

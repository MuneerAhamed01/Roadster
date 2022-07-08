import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:road_ster/application/bottomnavigation/bottomnavigation_cubit.dart';
import 'package:road_ster/application/car_details/car_details_bloc.dart';
import 'package:road_ster/application/scrolllistener/scroll_listener_cubit.dart';
import 'package:road_ster/main.dart';
import 'package:road_ster/presentation/bottom_nav/widget/bottomnav.dart';
import 'package:road_ster/presentation/car_list/car_list.dart';
import 'package:road_ster/presentation/home_screen/home_screen.dart';
import 'package:road_ster/presentation/settings/settings_screen.dart';
import 'package:road_ster/presentation/watchlist/watchlist.dart';

class BottomNavigation extends StatelessWidget {
   BottomNavigation({Key? key}) : super(key: key);
  final List<Widget> screen =  [
    const HomeScreen(),
    const CarListed(),
    WatchlistCar(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ScrollListenerCubit(),
        ),
        BlocProvider(
          create: (context) => BottomnavigationCubit(),
        ),
        BlocProvider(
          create: (context) => CarDetailsBloc(),
        ),
      ],
      child: BlocBuilder<BottomnavigationCubit, BottomnavigationState>(
          builder: (context, stateOne) {
        stateOne as BottomnavigationChanging;
        return Scaffold(
         
          body: NotificationListener<UserScrollNotification>(
              onNotification: (onNotification) {
                context.read<ScrollListenerCubit>().onScrolling(onNotification);
                return true;
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  screen[stateOne.index],
                  BlocBuilder<ScrollListenerCubit, ScrollListenerState>(
                      builder: (context, state) {
                    log("----------------------------------------------isworking---------------------------------------------------------");
                    state as ScrollListenerOnscrolling;

                    return BottomNavBarCustomized(
                      index: stateOne.index,
                      state: state.scrollNotification,
                    );
                  }),
                ],
              )),
        );
      }),
    );
  }
}

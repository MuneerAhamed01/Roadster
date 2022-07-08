import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:road_ster/domain/core/colors.dart';

import '../../application/addwatchlist/watchlistbutton_cubit.dart';

class IconOfDelete extends StatelessWidget {
  const IconOfDelete(
      {Key? key,
      required this.carid,
      this.radius = 15,
      required this.imageName,
      required this.align,
      required this.isWatchList,
      required this.carBrand})
      : super(key: key);
  final String carid;
  final String imageName;
  final AlignmentGeometry align;
  final bool isWatchList;
  final String carBrand;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WatchlistbuttonCubit(),
      child: BlocBuilder<WatchlistbuttonCubit, WatchlistbuttonState>(
        builder: (context, state) {
          // print("----------$carid-----___________coming car id----");
          // print(
          //     "----------625048df6b0888e62d15a0df--------------------------the CArID---------");
          return Align(
            alignment: align,
            child: GestureDetector(
              onTap: () {
                if (!isWatchList) {
                  if (state is WatchlistbuttonOnProcess) {
                    log("---------------------------------------------------------isGoingtoStatewithtrue---------------------------");
                    if (state.cheackIsOnWachList) {
                      log("---------------------------------------------------------deleteFromWatchList---------------------------");

                      context
                          .read<WatchlistbuttonCubit>()
                          .deleteFromWatchList(carid);
                    } else {
                      log("---------------------------------------------------------deleteFromWatchList---------------------------");

                      context
                          .read<WatchlistbuttonCubit>()
                          .addToWatchlist(carid);
                    }
                  } else {
                    log("---------------------------------------------------------notGoingThroughstate and adding---------------------------");

                    context.read<WatchlistbuttonCubit>().addToWatchlist(carid);
                  }
                } else {
                  log("---------------------------------------------------------watchlistfalse---------------------------");

                  if (state is WatchlistbuttonOnProcess) {
                    log("---------------------------------------------------------goingthroughstatewithfalse---------------------------");

                    if (state.cheackIsOnWachList) {
                      log("---------------------------------------------------------addingwithfalse---------------------------");

                      context
                          .read<WatchlistbuttonCubit>()
                          .deleteFromWatchList(carid);
                    } else {
                      log("---------------------------------------------------------deletingwithfalse---------------------------");

                      context
                          .read<WatchlistbuttonCubit>()
                          .addToWatchlist(carid);
                    }
                  } else {
                    // log("---------------------------------------------------------notstate and deleting false---------------------------");
                    log("---------$carBrand------------------------------------------------notstate and deleting false---------------------------");

                    context
                        .read<WatchlistbuttonCubit>()
                        .deleteFromWatchList(carid);
                  }
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 2,
                        blurStyle: BlurStyle.normal,
                        offset: Offset.fromDirection(2, 3))
                  ],
                ),
                child: CircleAvatar(
                  radius: radius,
                  backgroundColor: colorPalette1,
                  child: Icon(
                    state is WatchlistbuttonOnProcess
                        ? state.cheackIsOnWachList
                            ? FontAwesomeIcons.heartCircleCheck
                            : FontAwesomeIcons.heartCircleXmark
                        : isWatchList
                            ? FontAwesomeIcons.heartCircleCheck
                            : FontAwesomeIcons.heartCircleXmark,
                    size: 14,
                    color: state is WatchlistbuttonOnProcess
                        ? state.cheackIsOnWachList
                            ? Colors.red
                            : Colors.black
                        : isWatchList
                            ? Colors.red
                            : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

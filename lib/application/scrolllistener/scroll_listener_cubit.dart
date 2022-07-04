import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

part 'scroll_listener_state.dart';

class ScrollListenerCubit extends Cubit<ScrollListenerState> {
  ScrollListenerCubit() : super(ScrollListenerOnscrolling(true));
  void onScrolling(UserScrollNotification notification) {
    if (notification.direction == ScrollDirection.forward) {
      log("----------------------------------------------------------------------------------------------$notification");
      emit(ScrollListenerOnscrolling(true));
    } else if (notification.direction == ScrollDirection.reverse) {
      log("----------------------------------------------------------------------------------------------$notification");

      emit(ScrollListenerOnscrolling(false));
    }
  }
}

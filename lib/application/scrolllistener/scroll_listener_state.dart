part of 'scroll_listener_cubit.dart';

@immutable
abstract class ScrollListenerState {}

class ScrollListenerInitial extends ScrollListenerState {}

class ScrollListenerOnscrolling extends ScrollListenerState {
  final bool scrollNotification;

  ScrollListenerOnscrolling(this.scrollNotification);
}

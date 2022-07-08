part of 'watchlistbutton_cubit.dart';

@immutable
abstract class WatchlistbuttonState {}

class WatchlistbuttonInitial extends WatchlistbuttonState {}

class WatchlistbuttonOnProcess extends WatchlistbuttonState {
  final bool cheackIsOnWachList;

  WatchlistbuttonOnProcess({required this.cheackIsOnWachList});
}

class WatchlistbuttonOnDone extends WatchlistbuttonState {}

class WatchlistbuttonOnError extends WatchlistbuttonState {}

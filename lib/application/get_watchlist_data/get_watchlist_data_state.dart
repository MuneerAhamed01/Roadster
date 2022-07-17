part of 'get_watchlist_data_bloc.dart';

@immutable
abstract class GetWatchlistDataState {}

class GetWatchlistDataInitial extends GetWatchlistDataState {}

class GetWatchlistDataOnprocess extends GetWatchlistDataState {}

class GetWatchlistDataGetDone extends GetWatchlistDataState {
  final List<Datum>? carList;
  final List<String>? ids;
  final Position position;

  GetWatchlistDataGetDone({this.carList, this.ids,required this.position});
}

class GetWatchlistDataError extends GetWatchlistDataState {}

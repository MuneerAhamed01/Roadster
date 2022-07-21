part of 'get_watchlist_data_bloc.dart';

@immutable
abstract class GetWatchlistDataEvent {}

class GetWatchListData extends GetWatchlistDataEvent {}

class GetWatchListIstrue extends GetWatchlistDataEvent {}

class GetWatchListBySearch extends GetWatchlistDataEvent {
  final String value;

  GetWatchListBySearch(this.value);
}

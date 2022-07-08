part of 'search_view_watch_cubit.dart';

@immutable
abstract class SearchViewWatchState {}

class SearchViewWatchOnPressed extends SearchViewWatchState {
  final bool onPressed;
  SearchViewWatchOnPressed({required this.onPressed});
}

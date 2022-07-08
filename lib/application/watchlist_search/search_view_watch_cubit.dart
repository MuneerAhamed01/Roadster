import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_view_watch_state.dart';

class SearchViewWatchCubit extends Cubit<SearchViewWatchState> {
  SearchViewWatchCubit() : super(SearchViewWatchOnPressed(onPressed: false));

  void onPressed(bool stateValue) {
    emit(SearchViewWatchOnPressed(onPressed: !stateValue));
  }
}

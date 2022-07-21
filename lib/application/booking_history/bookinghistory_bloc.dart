import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:road_ster/application/car_details/car_details_bloc.dart';
import 'package:road_ster/domain/api_values/api.dart';
import 'package:road_ster/domain/get_user_details.dart';
import 'package:road_ster/domain/models/booking_details.dart';
import 'package:road_ster/domain/models/booking_history.dart';
import 'package:road_ster/infastructure/cache_data_repo.dart';
import 'package:road_ster/infastructure/login_and_signup/login_repository.dart';
import 'package:road_ster/infastructure/sort_car_order.dart';

import '../../domain/models/get_car_details.dart';

part 'bookinghistory_event.dart';
part 'bookinghistory_state.dart';

class BookinghistoryBloc
    extends Bloc<BookinghistoryEvent, BookinghistoryState> {
  BookinghistoryBloc() : super(BookinghistoryOnProcess()) {
    on<GetBookingHistoryEvent>((event, emit) async {
      emit(BookinghistoryOnProcess());
      String userId = GetUserDetailsFormSharedPRef().getUserDetails().id;
      final map = {"userId": userId};
      try {
        final responseUpcoming = await RepositoryHandler.bookingHistory(
            map, ApiValues.getPendingCarDetails);
        final responseCompleted = await RepositoryHandler.bookingHistory(
            map, ApiValues.getCompletedCarDetails);

        final responseCancelled = await RepositoryHandler.bookingHistory(
            map, ApiValues.getCancelledCarDetails);
        final res = await CacheDataRepository()
            .getCarFromCacheData(cacheDataFromCarDetails);

        final carDetailsFull = getCarDetailsFromJson(res).data;

        final upcoming = getBookingHistoryFromJson(responseUpcoming.data);
        final upcomingImageLink =
            SortingByOrder().imageLink(upcoming.bookingData, carDetailsFull);
        final completed = getBookingHistoryFromJson(responseCompleted.data);
                final completedImageLink =
            SortingByOrder().imageLink(completed.bookingData, carDetailsFull);
        final cancelled = getBookingHistoryFromJson(responseCancelled.data);
                final cancelledImageLink =
            SortingByOrder().imageLink(cancelled.bookingData, carDetailsFull);
        emit(BookinghistoryOnDone(
          cancelledImage: cancelledImageLink,
          completedImage: completedImageLink,
          upcomingImage: upcomingImageLink,
            cancelled: cancelled.bookingData,
            completed: completed.bookingData,
            upcoming: upcoming.bookingData));
      } catch (e) {
        print("----------${e.toString()}");
      }
    });
  }
}

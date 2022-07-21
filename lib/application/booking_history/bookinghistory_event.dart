part of 'bookinghistory_bloc.dart';

@immutable
abstract class BookinghistoryEvent {}

class GetBookingHistoryEvent extends BookinghistoryEvent {
  final List<BookingDetails>? upcoming;
  final List<BookingDetails>? completed;
  final List<BookingDetails>? cancelled;

  GetBookingHistoryEvent({this.upcoming, this.completed, this.cancelled});
}


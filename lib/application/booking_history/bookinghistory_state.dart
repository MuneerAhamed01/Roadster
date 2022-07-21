part of 'bookinghistory_bloc.dart';

@immutable
abstract class BookinghistoryState {}

class BookinghistoryOnProcess extends BookinghistoryState {}

class BookinghistoryOnDone extends BookinghistoryState {
  final List<BookingDatum>? upcoming;
  final List<BookingDatum>? completed;
  final List<BookingDatum>? cancelled;
  final List<String> upcomingImage;
  final List<String> completedImage;
  final List<String> cancelledImage;

  BookinghistoryOnDone({this.upcoming, this.completed, this.cancelled, required this.upcomingImage, required this.completedImage, required this.cancelledImage});

  
}

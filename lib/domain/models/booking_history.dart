// To parse this JSON data, do
//
//     final getBookingHistory = getBookingHistoryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetBookingHistory getBookingHistoryFromJson(String str) => GetBookingHistory.fromJson(json.decode(str));

String getBookingHistoryToJson(GetBookingHistory data) => json.encode(data.toJson());

class GetBookingHistory {
    GetBookingHistory({
        required this.bookingData,
    });

    final List<BookingDatum> bookingData;

    factory GetBookingHistory.fromJson(Map<String, dynamic> json) => GetBookingHistory(
        bookingData: List<BookingDatum>.from(json["bookingData"].map((x) => BookingDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "bookingData": List<dynamic>.from(bookingData.map((x) => x.toJson())),
    };
}

class BookingDatum {
    BookingDatum({
        required this.id,
        required this.carId,
        required this.userId,
        required this.username,
        required this.carname,
        required this.cancel,
        required this.complete,
        required this.startDate,
        required this.endDate,
        required this.payedAmount,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String id;
    final String carId;
    final String userId;
    final String username;
    final String carname;
    final bool cancel;
    final bool complete;
    final String startDate;
    final String endDate;
    final int payedAmount;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    factory BookingDatum.fromJson(Map<String, dynamic> json) => BookingDatum(
        id: json["_id"],
        carId: json["carId"],
        userId: json["userId"],
        username: json["username"],
        carname: json["carname"],
        cancel: json["cancel"],
        complete: json["complete"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        payedAmount: json["PayedAmount"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "carId": carId,
        "userId": userId,
        "username": username,
        "carname": carname,
        "cancel": cancel,
        "complete": complete,
        "startDate": startDate,
        "endDate": endDate,
        "PayedAmount": payedAmount,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

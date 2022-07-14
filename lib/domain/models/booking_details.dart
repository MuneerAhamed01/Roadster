// To parse this JSON data, do
//
//     final getBookingDetails = getBookingDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetBookingDetails getBookingDetailsFromJson(String str) => GetBookingDetails.fromJson(json.decode(str));

String getBookingDetailsToJson(GetBookingDetails data) => json.encode(data.toJson());

class GetBookingDetails {
    GetBookingDetails({
        required this.data,
    });

    final List<BookingDetails> data;

    factory GetBookingDetails.fromJson(Map<String, dynamic> json) => GetBookingDetails(
        data: List<BookingDetails>.from(json["data"].map((x) => BookingDetails.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class BookingDetails {
    BookingDetails({
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

    factory BookingDetails.fromJson(Map<String, dynamic> json) => BookingDetails(
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

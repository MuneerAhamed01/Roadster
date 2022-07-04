

import 'package:meta/meta.dart';
import 'dart:convert';

GetCarDetails getCarDetailsFromJson(String str) => GetCarDetails.fromJson(json.decode(str));

String getCarDetailsToJson(GetCarDetails data) => json.encode(data.toJson());

class GetCarDetails {
    GetCarDetails({
        required this.data,
    });

    final List<Datum> data;

    factory GetCarDetails.fromJson(Map<String, dynamic> json) => GetCarDetails(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.id,
        required this.brand,
        required this.model,
        required this.fueltype,
        required this.regNo,
        required this.price,
        required this.seats,
        required this.location,
        required this.mileage,
        required this.register,
        required this.description,
        required this.imgUrl,
        required this.url,
        required this.imgName,
        required this.longdescription,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.offerStatus,
        required this.prevAmount,
        required this.latitude,
        required this.longitude,
        required this.bookingcount,
    });

    final String id;
    final String brand;
    final String model;
    final Fueltype fueltype;
    final String regNo;
    final int price;
    final int seats;
    final String location;
    final String mileage;
    final String register;
    final String description;
    final String imgUrl;
    final String url;
    final String imgName;
    final String longdescription;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;
    final bool offerStatus;
    final int prevAmount;
    final double latitude;
    final double longitude;
    final int bookingcount;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        brand: json["brand"],
        model: json["model"],
        fueltype: fueltypeValues.map[json["fueltype"]]!,
        regNo: json["RegNo"],
        price: json["price"],
        seats: json["seats"],
        location: json["location"],
        mileage: json["mileage"],
        register: json["register"],
        description: json["description"],
        imgUrl: json["imgUrl"],
        url: json["url"],
        imgName: json["imgName"],
        longdescription: json["Longdescription"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        offerStatus: json["OfferStatus"],
        prevAmount: json["prevAmount"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        bookingcount: json["Bookingcount"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "brand": brand,
        "model": model,
        "fueltype": fueltypeValues.reverse[fueltype],
        "RegNo": regNo,
        "price": price,
        "seats": seats,
        "location": location,
        "mileage": mileage,
        "register": register,
        "description": description,
        "imgUrl": imgUrl,
        "url": url,
        "imgName": imgName,
        "Longdescription": longdescription,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "OfferStatus": offerStatus,
        "prevAmount": prevAmount,
        "latitude": latitude,
        "longitude": longitude,
        "Bookingcount": bookingcount,
    };
}

enum Fueltype { PETROL, DIESEL }

final fueltypeValues = EnumValues({
    "Diesel": Fueltype.DIESEL,
    "Petrol": Fueltype.PETROL
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap ??= map.map((k, v) => new MapEntry(v, k));
        return reverseMap!;
    }
}

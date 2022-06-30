// To parse this JSON data, do
//
//     final getUsersDetails = getUsersDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<GetUsersDetails> getUsersDetailsFromJson(String str) => List<GetUsersDetails>.from(json.decode(str).map((x) => GetUsersDetails.fromJson(x)));

String getUsersDetailsToJson(List<GetUsersDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetUsersDetails {
    GetUsersDetails({
        required this.id,
        required this.name,
        required this.email,
        required this.phone,
        required this.age,
        required this.gender,
        required this.address,
        required this.district,
        required this.password,
        required this.isBlock,
        required this.wishlist,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    String id;
    String name;
    String email;
    int phone;
    int age;
    GenderModel gender;
    String address;
    String district;
    String password;
    bool isBlock;
    List<String> wishlist;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory GetUsersDetails.fromJson(Map<String, dynamic> json) => GetUsersDetails(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        age: json["age"],
        gender: genderValues.map[json["gender"]]!,
        address: json["address"],
        district: json["district"],
        password: json["password"],
        isBlock: json["isBlock"],
        wishlist: List<String>.from(json["wishlist"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "age": age,
        "gender": genderValues.reverse[gender],
        "address": address,
        "district": district,
        "password": password,
        "isBlock": isBlock,
        "wishlist": List<dynamic>.from(wishlist.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

enum GenderModel { MALE, FEMALE }

final genderValues = EnumValues({
    "Female": GenderModel.FEMALE,
    "Male": GenderModel.MALE
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap ??= map.map((k, v) =>  MapEntry(v, k));
        return reverseMap!;
    }
}

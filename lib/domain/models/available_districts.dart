
import 'package:meta/meta.dart';
import 'dart:convert';

GetDistrictDetails getDistrictDetailsFromJson(String str) => GetDistrictDetails.fromJson(json.decode(str));

String getDistrictDetailsToJson(GetDistrictDetails data) => json.encode(data.toJson());

class GetDistrictDetails {
    GetDistrictDetails({
        required this.getdistrict,
    });

    final List<Getdistrict> getdistrict;

    factory GetDistrictDetails.fromJson(Map<String, dynamic> json) => GetDistrictDetails(
        getdistrict: List<Getdistrict>.from(json["Getdistrict"].map((x) => Getdistrict.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Getdistrict": List<dynamic>.from(getdistrict.map((x) => x.toJson())),
    };
}

class Getdistrict {
    Getdistrict({
        required this.id,
        required this.district,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String id;
    final String district;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    factory Getdistrict.fromJson(Map<String, dynamic> json) => Getdistrict(
        id: json["_id"],
        district: json["district"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "district": district,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

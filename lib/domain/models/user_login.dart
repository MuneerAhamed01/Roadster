// To parse this JSON data, do
//
//     final loginDetails = loginDetailsFromJson(jsonString);

import 'dart:convert';

LoginDetails loginDetailsFromJson(String str) => LoginDetails.fromJson(json.decode(str));

String loginDetailsToJson(LoginDetails data) => json.encode(data.toJson());

class LoginDetails {
    LoginDetails({
        required this.id,
        required this.email,
        required this.loginDetailsIsBlock,
        required this.name,
        required this.isBlock,
        required this.token,
    });

    String id;
    String email;
    bool loginDetailsIsBlock;
    String name;
    bool isBlock;
    String token;

    factory LoginDetails.fromJson(Map<String, dynamic> json) => LoginDetails(
        id: json["_id"],
        email: json["email"],
        loginDetailsIsBlock: json["isBlock"],
        name: json["name"],
        isBlock: json["IsBlock"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "isBlock": loginDetailsIsBlock,
        "name": name,
        "IsBlock": isBlock,
        "token": token,
    };
}

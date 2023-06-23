
// To parse this JSON data, do
//
//     final userReq = userReqFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

String userReqToJson(UserReq data) => json.encode(data.toJson());

class UserReq {
  String title;
  String thumbnailUrl;

  UserReq({
    required this.title,
    required this.thumbnailUrl
  });


  Map<String, dynamic> toJson() => {
    "title": title,
    "thumbnailUrl": thumbnailUrl
  };
}

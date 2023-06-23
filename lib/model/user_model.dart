

// To parse this JSON data, do
//
//     final userRecord = userRecordFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<UserRecord> userRecordFromJson(String str) => List<UserRecord>.from(json.decode(str).map((x) => UserRecord.fromJson(x)));

String userRecordToJson(List<UserRecord> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserRecord {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  UserRecord({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory UserRecord.fromJson(Map<String, dynamic> json) => UserRecord(
    albumId: json["albumId"],
    id: json["id"],
    title: json["title"],
    url: json["url"],
    thumbnailUrl: json["thumbnailUrl"],
  );

  Map<String, dynamic> toJson() => {
    "albumId": albumId,
    "id": id,
    "title": title,
    "url": url,
    "thumbnailUrl": thumbnailUrl,
  };
}

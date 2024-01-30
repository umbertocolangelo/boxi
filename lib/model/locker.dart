import 'package:cloud_firestore/cloud_firestore.dart';

class Locker {
  final String id;
  final String name;
  final GeoPoint location;
  final String picturePath;

  Locker(
      {required this.id,
      required this.name,
      required this.location,
      required this.picturePath});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "location": location,
      "picture_path": picturePath
    };
  }

  factory Locker.fromJson(Map<String, dynamic> json) {
    return Locker(
        id: json['id'],
        name: json['name'],
        location: json['location'],
        picturePath: json['picture_path']);
  }

}

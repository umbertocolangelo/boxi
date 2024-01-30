import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation {
  String id;
  String lockerId;
  String customerId;
  String boxId;
  String? deliveryId;
  Timestamp startTime;
  Timestamp endTime;
  double cost;
  String status;

  Reservation(
      {required this.id,
      required this.lockerId,
      required this.customerId,
      required this.boxId,
      this.deliveryId,
      required this.startTime,
      required this.endTime,
      required this.cost,
      required this.status});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "lockerId": lockerId,
      "customerId": customerId,
      "boxId": boxId,
      "deliveryId": deliveryId,
      "startTime": startTime,
      "endTime": endTime,
      "cost": cost,
      "status": status,
    };
  }

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
        id: json['id'],
        lockerId: json['lockerId'],
        customerId: json['customerId'],
        boxId: json['boxId'],
        deliveryId: json['deliveryId'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        cost: json['cost'], 
        status: json['status']);
  }

}

import 'package:cloud_firestore/cloud_firestore.dart';

class Delivery {
  String id;
  String boxId;
  String customerId;
  String riderId;
  String fromLockerId;
  String toLockerId;
  Timestamp deliveryDate;
  Timestamp withinTime;
  bool isDelivered;
  String status;

  Delivery(
      {required this.id,
      required this.boxId,
      required this.customerId,
      required this.riderId,
      required this.fromLockerId,
      required this.toLockerId,
      required this.deliveryDate,
      required this.withinTime,
      this.isDelivered = false,
      required this.status});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "boxId": boxId,
      "customerId": customerId,
      "riderId": riderId,
      "fromLockerId": fromLockerId,
      "toLockerId": toLockerId,
      "deliveryDate": deliveryDate,
      "withinTime": withinTime,
      "isDelivered": isDelivered,
      "status": status
    };
  }

  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
        id: json['id'],
        boxId: json['boxId'],
        customerId: json['customerId'],
        riderId: json['riderId'],
        fromLockerId: json['fromLockerId'],
        toLockerId: json['toLockerId'],
        deliveryDate: json['deliveryDate'],
        withinTime: json['withinTime'],
        isDelivered: json['isDelivered'],
        status: json['status']);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boxi/model/delivery.dart';

class DeliveryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //get all deliveries
  Future<List<Delivery>> getDeliveries() async {
    var result = await _db.collection('delivery').get();
    List<Delivery> deliveries =
        result.docs.map((doc) => Delivery.fromJson(doc.data())).toList();
    return deliveries;
  }

  //get delivery by id
  Future<Delivery> getDeliveryById(String deliveryId) async {
    var result = await _db.collection('delivery').where('id', isEqualTo: deliveryId).get();
    Delivery delivery = Delivery.fromJson(result.docs.first.data());
    return delivery;
  }

  //add delivery
  Future<void> addDelivery(Map<String, dynamic> deliveryData) async {
    await _db
      .collection('delivery')
      .add(deliveryData);
  }

  //update Delivery
  Future<void> updateDelivery(
      String deliveryId, Map<String, dynamic> newData) async {
    await _db
      .collection('delivery')
      .doc(deliveryId)
      .update(newData);
  }

  //delete Delivery
  Future<void> deleteDelivery(String deliveryId) async {
    await _db
      .collection('delivery')
      .doc(deliveryId)
      .delete();
  }
}

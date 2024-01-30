import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boxi/model/rider.dart';

class RiderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //get all deliveries
  Future<List<Rider>> getRiders() async {
    var result = await _db.collection('Rider').get();
    List<Rider> riders =
        result.docs.map((doc) => Rider.fromJson(doc.data())).toList();
    return riders;
  }

  //get Rider by id
  Future<Rider> getRiderById(String riderId) async {
    var result = await _db.collection('rider').where('id', isEqualTo: riderId).get();
    Rider rider = Rider.fromJson(result.docs.first.data());
    return rider;
  }

  //add Rider
  Future<void> addRider(Map<String, dynamic> riderData) async {
    await _db
      .collection('rider')
      .add(riderData);
  }

  //update Rider
  Future<void> updateRider(
      String riderId, Map<String, dynamic> newData) async {
    await _db
      .collection('rider')
      .doc(riderId)
      .update(newData);
  }

  //delete Rider
  Future<void> deleteRider(String riderId) async {
    await _db
      .collection('Rider')
      .doc(riderId)
      .delete();
  }
}

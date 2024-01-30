// Purpose:  To provide the service for the locker
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boxi/model/locker.dart';

class LockerService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //get all lockers
  Future<List<Locker>> getLockers() async {
    var result = await _db.collection('locker').get();
    List<Locker> lockers =
        result.docs.map((doc) => Locker.fromJson(doc.data())).toList();
    return lockers;
  }

  //get locker by id
  Future<Locker> getLockerById(String id) async {
    var result = await _db.collection('locker').where(id, isEqualTo: id).get();
    Locker locker = Locker.fromJson(result.docs.first.data());
    return locker;
  }

  //add locker
  Future<void> addLocker(Map<String, dynamic> lockerData) async {
    await _db
      .collection('locker')
      .add(lockerData);
  }

  //update locker
  Future<void> updateLocker(
      String lockerId, Map<String, dynamic> newData) async {
    await _db
      .collection('locker')
      .doc(lockerId)
      .update(newData);
  }

  //delete locker
  Future<void> deleteLocker(String lockerId) async {
    await _db
      .collection('locker')
      .doc(lockerId)
      .delete();
  }
}

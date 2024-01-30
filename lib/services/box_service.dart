import 'package:boxi/model/box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BoxService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //get all boxes
  Future<List<Box>> getBoxes() async {
    var result = await _db.collection('box').get();
    List<Box> boxes =
        result.docs.map((doc) => Box.fromJson(doc.data())).toList();
    return boxes;
  }

  //get box by id
  Future<Box> getBoxById(String id) async {
    var result = await _db.collection('box').where(id, isEqualTo: id).get();
    Box box = Box.fromJson(result.docs.first.data());
    return box;
  }

  //add box
  Future<void> addBox(Map<String, dynamic> boxData) async {
    await _db
      .collection('box')
      .add(boxData);
  }

  //update box
  Future<void> updateBox(
      String boxId, Map<String, dynamic> newData) async {
    await _db
      .collection('box')
      .doc(boxId)
      .update(newData);
  }

  //delete box
  Future<void> deleteBox(String boxId) async {
    await _db
      .collection('box')
      .doc(boxId)
      .delete();
  }

  //get box by locker id
  Future<List<Box>> getBoxByLockerId(String lockerId) async {
    var result = await _db
        .collection('box')
        .where('lockerId', isEqualTo: lockerId)
        .get();
    List<Box> boxes =
        result.docs.map((doc) => Box.fromJson(doc.data())).toList();
    return boxes;
  }

}

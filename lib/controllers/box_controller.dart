import 'package:boxi/model/box.dart';
import 'package:boxi/services/box_service.dart';
import 'package:flutter/cupertino.dart';

class BoxController with ChangeNotifier{
  
  final BoxService _boxService = BoxService();

  Future<List<Box>> fetchBoxes() async {
    try {
      return await _boxService.getBoxes();
    } catch (error) {
      // Handle errors, e.g., show an error message to the locker
      print('Error fetching Boxes: $error');
      rethrow;
    }
  }

  Future<void> addBox(Map<String, dynamic> boxData) async {
    try {
      await _boxService.addBox(boxData);
    } catch (error) {
      // Handle errors, e.g., show an error message to the locker
      print('Error adding Box: $error');
    }
  }

  Future<void> updateBox(
      String boxId, Map<String, dynamic> newData) async {
    try {
      await _boxService.updateBox(boxId, newData);
    } catch (error) {
      // Handle errors, e.g., show an error message to the locker
      print('Error updating Box: $error');
    }
  }

  Future<void> deleteBox(String boxId) async {
    try {
      await _boxService.deleteBox(boxId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the locker
      print('Error deleting Box: $error');
    }
  }

  //get box by id
  Future<Box> getBoxById(String boxId) async {
    try {
      return await _boxService.getBoxById(boxId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the locker
      print('Error getting Box: $error');
      rethrow;
    }
  }

  //get box by locker id
  Future<List<Box>> getBoxByLockerId(String lockerId) async {
    try {
      return await _boxService.getBoxByLockerId(lockerId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the locker
      print('Error getting Box: $error');
      rethrow;
    }
  }

}
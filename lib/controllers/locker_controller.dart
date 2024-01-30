import 'package:boxi/model/locker.dart';
import 'package:boxi/services/locker_service.dart';
import 'package:flutter/cupertino.dart';

class LockerController with ChangeNotifier{
  final LockerService _lockerService = LockerService();
  List<Locker> lockers = [];

  Future<List<Locker>> fetchLockers() async {
    try {
      lockers = await _lockerService.getLockers();
      return lockers;
    } catch (error) {
      // Handle errors, e.g., show an error message to the locker
      print('Error fetching Lockers: $error');
      rethrow;
    }
  }

  Future<void> addLocker(Map<String, dynamic> lockerData) async {
    try {
      await _lockerService.addLocker(lockerData);
    } catch (error) {
      // Handle errors, e.g., show an error message to the locker
      print('Error adding Locker: $error');
    }
  }

  Future<void> updateLocker(
      String lockerId, Map<String, dynamic> newData) async {
    try {
      await _lockerService.updateLocker(lockerId, newData);
    } catch (error) {
      // Handle errors, e.g., show an error message to the locker
      print('Error updating Locker: $error');
    }
  }

  Future<void> deleteLocker(String lockerId) async {
    try {
      await _lockerService.deleteLocker(lockerId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the locker
      print('Error deleting Locker: $error');
    }
  }

  Future<Locker> getLockerById(String lockerId) async {
    try {
      return await _lockerService.getLockerById(lockerId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the locker
      print('Error getting Locker: $error');
      rethrow;
    }
  }
}

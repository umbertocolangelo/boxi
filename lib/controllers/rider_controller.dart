import 'package:boxi/model/rider.dart';
import 'package:boxi/services/rider_service.dart';
import 'package:flutter/cupertino.dart'; 

class RiderController with ChangeNotifier{
  final RiderService _riderService = RiderService();
  List<Rider> riders = [];

  Future<List<Rider>> fetchRiders() async {
    try {
      riders = await _riderService.getRiders();
      return riders;
    } catch (error) {
      // Handle errors, e.g., show an error message to the Rider
      print('Error fetching riders: $error');
      rethrow;
    }
  }

  Future<void> addRider(Map<String, dynamic> riderData) async {
    try {
      await _riderService.addRider(riderData);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Rider
      print('Error adding Rider: $error');
    }
  }

  Future<void> updateRider(
      String riderId, Map<String, dynamic> newData) async {
    try {
      await _riderService.updateRider(riderId, newData);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Rider
      print('Error updating Rider: $error');
    }
  }

  Future<void> deleteRider(String riderId) async {
    try {
      await _riderService.deleteRider(riderId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Rider
      print('Error deleting Rider: $error');
    }
  }

  Future<Rider> getRiderById(String riderId) async {
    try {
      return await _riderService.getRiderById(riderId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Rider
      print('Error getting Rider: $error');
      rethrow;
    }
  }
}

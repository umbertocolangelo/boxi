import 'package:boxi/model/delivery.dart';
import 'package:boxi/services/delivery_service.dart';
import 'package:flutter/cupertino.dart'; 

class DeliveryController with ChangeNotifier{
  final DeliveryService _deliveryService = DeliveryService();
  List<Delivery> deliveries = [];

  Future<List<Delivery>> fetchDeliveries() async {
    try {
      deliveries = await _deliveryService.getDeliveries();
      return deliveries;
    } catch (error) {
      // Handle errors, e.g., show an error message to the Delivery
      print('Error fetching Deliveries: $error');
      rethrow;
    }
  }

  Future<void> addDelivery(Map<String, dynamic> deliveryData) async {
    try {
      await _deliveryService.addDelivery(deliveryData);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Delivery
      print('Error adding Delivery: $error');
    }
  }

  Future<void> updateDelivery(
      String deliveryId, Map<String, dynamic> newData) async {
    try {
      await _deliveryService.updateDelivery(deliveryId, newData);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Delivery
      print('Error updating Delivery: $error');
    }
  }

  Future<void> deleteDelivery(String deliveryId) async {
    try {
      await _deliveryService.deleteDelivery(deliveryId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Delivery
      print('Error deleting Delivery: $error');
    }
  }

  Future<Delivery> getDeliveryById(String deliveryId) async {
    try {
      return await _deliveryService.getDeliveryById(deliveryId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Delivery
      print('Error getting Delivery: $error');
      rethrow;
    }
  }
}

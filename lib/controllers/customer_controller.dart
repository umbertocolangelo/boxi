import 'package:boxi/model/customer.dart';
import 'package:boxi/services/customer_service.dart';
import 'package:flutter/cupertino.dart';

class CustomerController with ChangeNotifier{
  final CustomerService _customerService = CustomerService();
  List<Customer> customers = [];

  Future<List<Customer>> fetchCustomers() async {
    try {
      customers = await _customerService.getCustomers();
      return customers;
    } catch (error) {
      // Handle errors, e.g., show an error message to the Customer
      print('Error fetching Customers: $error');
      rethrow;
    }
  }
  
  Future<void> addCustomer(Map<String, dynamic> customerData) async {
    try {
      await _customerService.addCustomer(customerData);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Customer
      print('Error adding Customer: $error');
    }
  }

  Future<void> updateCustomer(
      String customerId, Map<String, dynamic> newData) async {
    try {
      await _customerService.updateCustomer(customerId, newData);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Customer
      print('Error updating Customer: $error');
    }
  }

  Future<void> deleteCustomer(String customerId) async {
    try {
      await _customerService.deleteCustomer(customerId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Customer
      print('Error deleting Customer: $error');
    }
  }

  Future<Customer> getCustomerById(String customerId) async {
    try {
      return await _customerService.getCustomerById(customerId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Customer
      print('Error getting Customer: $error');
      rethrow;
    }
  }
}

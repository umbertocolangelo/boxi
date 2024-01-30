import 'package:boxi/model/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Customer>> getCustomers() async {
    var result = await _db.collection('customer').get();
    List<Customer> customers =
        result.docs.map((doc) => Customer.fromJson(doc.data())).toList();
    return customers;
  }

  Future<void> addCustomer(Map<String, dynamic> customerData) async {
    await _db
      .collection('customer')
      .add(customerData);
  }

  Future<void> updateCustomer(
      String customerId, Map<String, dynamic> newData) async {
    await _db
      .collection('customer')
      .doc(customerId)
      .update(newData);
  }

  Future<void> deleteCustomer(String customerId) async {
    await _db
      .collection('customer')
      .doc(customerId)
      .delete();
  }

  //get customer by id
  Future<Customer> getCustomerById(String customerId) async {
    var result = await _db.collection('customer').where('id', isEqualTo: customerId).get();
    Customer customer = Customer.fromJson(result.docs.first.data());
    return customer;
  }

}

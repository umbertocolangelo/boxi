import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boxi/model/reservation.dart';

class ReservationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //get all reservations
  Future<List<Reservation>> getReservations() async {
    var result = await _db.collection('reservation').get();
    final List<Reservation> reservations = 
      result.docs.map((doc) => Reservation.fromJson(doc.data())).toList();
    return reservations;
  }

  //get reservation by id
  Future<Reservation> getReservationById(String reservationId) async {
    var result = await _db.collection('reservation').where('id', isEqualTo: reservationId).get();
    Reservation reservation = Reservation.fromJson(result.docs.first.data());
    return reservation;
  }

  //get reservation by customer id
  Future<List<Reservation>> getReservationByCustomerId(String reservationId) async {
    var result = await _db
        .collection('reservation')
        .where('customerId', isEqualTo: reservationId)
        .get();
    List<Reservation> reservations =
        result.docs.map((doc) => Reservation.fromJson(doc.data())).toList();
    return reservations;
  }

  //add reservation
  Future<void> addReservation(Map<String, dynamic> reservationData) async {
    await _db.collection('reservation').add(reservationData);
  }

  //update reservation
  Future<void> updateReservation(
      String reservationId, Map<String, dynamic> newData) async {
    await _db
        .collection('reservation')
        .doc(reservationId)
        .update(newData);
  }

  //delete reservation
  Future<void> deleteReservation(String reservationId) async {
    await _db
      .collection('reservation')
      .doc(reservationId)
      .delete();
  }
}

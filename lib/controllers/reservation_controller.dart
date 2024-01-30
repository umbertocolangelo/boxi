import 'package:boxi/model/reservation.dart';
import 'package:boxi/services/reservation_service.dart';
import 'package:flutter/cupertino.dart';

class ReservationController with ChangeNotifier{
  final ReservationService _reservationService = ReservationService();
  List<Reservation> reservations = [];

  Future<List<Reservation>> fetchReservations() async {
    try {
      reservations = await _reservationService.getReservations();
      return reservations;
    } catch (error) {
      // Handle errors, e.g., show an error message to the reservation
      print('Error fetching Reservations: $error');
      rethrow;
    }
  }

  Future<void> addReservation(Map<String, dynamic> reservationData) async {
    try {
      await _reservationService.addReservation(reservationData);
    } catch (error) {
      // Handle errors, e.g., show an error message to the reservation
      print('Error adding Reservation: $error');
    }
  }

  Future<void> updateReservation(
      String reservationId, Map<String, dynamic> newData) async {
    try {
      await _reservationService.updateReservation(reservationId, newData);
    } catch (error) {
      // Handle errors, e.g., show an error message to the reservation
      print('Error updating Reservation: $error');
    }
  }

  Future<void> deleteReservation(String reservationId) async {
    try {
      await _reservationService.deleteReservation(reservationId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the reservation
      print('Error deleting Reservation: $error');
    }
  }

  Future<Reservation> getReservationById(String reservationId) async {
    try {
      return await _reservationService.getReservationById(reservationId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the reservation
      print('Error getting Reservation: $error');
      rethrow;
    }
  }

  Future<List<Reservation>> getReservationByCustomerId(String customerId) async {
    try {
      reservations = await _reservationService.getReservationByCustomerId(customerId);
      return reservations;
    } catch (error) {
      // Handle errors, e.g., show an error message to the reservation
      print('Error getting Reservation: $error');
      rethrow;
    }
  }
}

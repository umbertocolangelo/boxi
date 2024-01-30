import 'dart:async';

import 'package:boxi/controllers/locker_controller.dart';
import 'package:boxi/controllers/reservation_controller.dart';
import 'package:boxi/pages/locker_map_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    LockerController lockerController = LockerController();
    lockerController.fetchLockers();
    ReservationController reservationController = ReservationController();
    reservationController.fetchReservations();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MapPage(label: 'Map'))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/logo.jpeg',
              width: 300,
              height: 300,
            ),
          ),
          Padding(padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(
              strokeWidth: 5,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.black.withOpacity(0.5)),
            ),
          ),),
        ],
      ),
    );
  }
}

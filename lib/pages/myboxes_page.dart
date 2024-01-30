import 'package:boxi/controllers/delivery_controller.dart';
import 'package:boxi/controllers/locker_controller.dart';
import 'package:boxi/controllers/reservation_controller.dart';
import 'package:boxi/controllers/rider_controller.dart';
import 'package:boxi/model/delivery.dart';
import 'package:boxi/model/locker.dart';
import 'package:boxi/model/reservation.dart';
import 'package:boxi/model/rider.dart';
import 'package:boxi/widgets/appbar_widget.dart';
import 'package:boxi/widgets/reservation_items_widget.dart';
import 'package:boxi/widgets/bottom_bar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyBoxesPage extends StatefulWidget {
  final String label;
  const MyBoxesPage({required this.label, super.key});

  @override
  _MyBoxesPageState createState() => _MyBoxesPageState();
}

class _MyBoxesPageState extends State<MyBoxesPage> {
  @override
  void initState() {
    super.initState();
    ReservationController reservationController = ReservationController();
    reservationController.fetchReservations();
  }

  @override
  Widget build(BuildContext context) {
    ReservationController reservationController = ReservationController();
    LockerController lockerController = LockerController();
    DeliveryController deliveryController = DeliveryController();
    RiderController riderController = RiderController();
    return Container(
      padding: const EdgeInsets.all(0),
      child: FutureBuilder(
        future: Future.wait([
          reservationController.getReservationByCustomerId('1'),
          lockerController.fetchLockers(),
          deliveryController.fetchDeliveries(),
          riderController.getRiderById('1')
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Scaffold(
                body: Column(
                  children: [
                    Expanded(flex: 1, child: AppBarWidget(label: widget.label)),
                    Expanded(
                      flex: 7,
                      child: _listView(
                          context,
                          snapshot.data?[0] as List<Reservation>,
                          snapshot.data?[1] as List<Locker>,
                          snapshot.data?[2] as List<Delivery>,
                          snapshot.data?[3] as Rider),
                    ),
                    const Expanded(
                      child: BottomBarWidget(),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          } else {
            return Center(
                child: SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                strokeWidth: 5,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.black.withOpacity(0.5)),
              ),
            ));
          }
        },
      ),
    );
  }

  Widget _listView(BuildContext context, List<Reservation> reservations,
      List<Locker> lockers, List<Delivery> deliveries, Rider rider) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        ListView.builder(
          itemCount: reservations.length,
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0)),
              child: WidgetReservationItem(
                reservation: reservations[index],
                locker: reservations[index].deliveryId == null
                    ? getLockerById(lockers, reservations[index].lockerId)
                    : getLockerById(
                        lockers,
                        getDeliveryById(
                                deliveries, reservations[index].deliveryId!)
                            .toLockerId),
                sourceLocker: reservations[index].deliveryId == null
                    ? null
                    : getLockerById(
                        lockers,
                        getDeliveryById(
                                deliveries, reservations[index].deliveryId!)
                            .fromLockerId),
                delivery: reservations[index].deliveryId == null
                    ? null
                    : getDeliveryById(
                        deliveries, reservations[index].deliveryId!),
                rider: rider,
              ),
            );
          },
        )
      ],
    );
  }

  Locker getLockerById(List<Locker> lockers, String lockerId) {
    GeoPoint location = const GeoPoint(0, 0);
    for (var locker in lockers) {
      if (locker.id == lockerId) {
        return locker;
      }
    }
    return Locker(
      id: '',
      name: '',
      location: location,
      picturePath: '',
    );
  }

  Delivery getDeliveryById(List<Delivery> deliveries, String deliveryId) {
    for (var delivery in deliveries) {
      if (delivery.id == deliveryId) {
        return delivery;
      }
    }
    return Delivery(
      id: '',
      customerId: '',
      riderId: '',
      boxId: '',
      fromLockerId: '',
      toLockerId: '',
      status: '',
      withinTime: Timestamp.now(),
      deliveryDate: Timestamp.now(),
    );
  }
}

import 'package:boxi/model/delivery.dart';
import 'package:boxi/model/locker.dart';
import 'package:boxi/model/reservation.dart';
import 'package:boxi/model/rider.dart';
import 'package:boxi/pages/myboxes_page.dart';
import 'package:boxi/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:boxi/controllers/reservation_controller.dart';

class ReservationDetailsPage extends StatefulWidget {
  final Reservation reservation;
  final Locker locker;
  final Locker? sourceLocker;
  final Delivery? delivery;
  final Rider rider;
  final String label;

  const ReservationDetailsPage(
      {required this.reservation,
      required this.locker,
      this.sourceLocker,
      this.delivery,
      required this.rider,
      required this.label,
      super.key});

  @override
  _ReservationDetailsPageState createState() => _ReservationDetailsPageState();
}

class _ReservationDetailsPageState extends State<ReservationDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 1, child: AppBarWidget(label: widget.label)),
          Expanded(
            flex: 7,
            child: reservationDetailUI(widget.reservation, widget.locker,
                widget.sourceLocker, widget.delivery, widget.rider),
          ),
        ],
      ),
    );
  }

  Widget reservationDetailUI(Reservation reservation, Locker locker,
      Locker? sourceLocker, Delivery? delivery, Rider rider) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _reservationStatus(reservation.status),
            const Divider(
              color: Colors.grey,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconText(
                    const Icon(
                      Icons.receipt,
                      color: Colors.blue,
                    ),
                    const Text(
                      "Reservation ID",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                Text(
                  reservation.id,
                  style: const TextStyle(fontSize: 14),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconText(
                    const Icon(
                      Icons.today,
                      color: Colors.blue,
                    ),
                    const Text(
                      "Start Time",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                Text(
                  reservation.startTime.toDate().toString().substring(0, 19),
                  style: const TextStyle(fontSize: 14),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconText(
                    const Icon(
                      Icons.calendar_month,
                      color: Colors.blue,
                    ),
                    const Text(
                      "End Time",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                Text(
                  reservation.endTime.toDate().toString().substring(0, 19),
                  style: const TextStyle(fontSize: 14),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconText(
                    const Icon(
                      Icons.attach_money,
                      color: Colors.blue,
                    ),
                    const Text(
                      "Price",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                Text(
                  reservation.cost.toString() + " €",
                  style: const TextStyle(fontSize: 14),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconText(
                    const Icon(
                      Icons.lock,
                      color: Colors.blue,
                    ),
                    const Text(
                      "Box ID",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                Text(
                  reservation.boxId,
                  style: const TextStyle(fontSize: 14),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            reservation.deliveryId == null
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          iconText(
                              const Icon(
                                Icons.location_on,
                                color: Colors.blue,
                              ),
                              const Text(
                                "Locker",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )),
                          Text(
                            locker.name,
                            style: const TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          iconText(
                              const Icon(
                                Icons.location_on,
                                color: Colors.blue,
                              ),
                              const Text(
                                "Source Locker",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )),
                          Text(
                            sourceLocker!.name,
                            style: const TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          iconText(
                              const Icon(
                                Icons.location_on,
                                color: Colors.blue,
                              ),
                              const Text(
                                "Destination Locker",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )),
                          Text(
                            locker.name,
                            style: const TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          iconText(
                              const Icon(
                                Icons.directions,
                                color: Colors.blue,
                              ),
                              const Text(
                                "Delivery ID",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )),
                          Text(
                            reservation.deliveryId!,
                            style: const TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          iconText(
                              const Icon(
                                Icons.person,
                                color: Colors.blue,
                              ),
                              const Text(
                                "Delivered By",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )),
                          Text(
                            rider.firstName + " " + rider.lastName,
                            style: const TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          iconText(
                              const Icon(
                                Icons.delivery_dining,
                                color: Colors.blue,
                              ),
                              const Text(
                                "Until",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )),
                          Text(
                            delivery!.withinTime
                                .toDate()
                                .toString()
                                .substring(0, 19),
                            style: const TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),

            //cancel reservation button
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Cancel Reservation"),
                          content: const Text(
                              "Are you sure you want to cancel this reservation?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("NO")),
                            TextButton(
                                onPressed: () {
                                  ReservationController()
                                      .deleteReservation(reservation.id);
                                  //go to my boxes page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyBoxesPage(
                                        label: "My Boxes",
                                      ),
                                    ),
                                  );
                                },
                                child: const Text("YES")),
                          ],
                        );
                      });
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Cancel Reservation ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.clear_outlined,
                      color: Colors.white,
                    ),
                  ],
                )),
          ],
        ));
  }

  Widget iconText(Icon iconWidget, Text textWidget) {
    return Row(
      children: [
        iconWidget,
        const SizedBox(
          width: 10,
        ),
        textWidget
      ],
    );
  }

  Widget textButton(Widget iconText, Color color, Function onPressed) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(10),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: iconText,
    );
  }

  Widget _reservationStatus(String status) {
    if (status == "active") {
      return const Icon(Icons.access_alarm, color: Colors.black);
    } else if (status == "completed") {
      return const Icon(
        Icons.check,
        color: Colors.black,
      );
    } else if (status == "cancelled") {
      return const Icon(
        Icons.clear,
        color: Colors.red,
      );
    } else {
      return const Icon(
        Icons.error,
        color: Colors.red,
      );
    }
  }
}

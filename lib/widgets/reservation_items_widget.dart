import 'package:boxi/model/delivery.dart';
import 'package:boxi/model/locker.dart';
import 'package:boxi/model/reservation.dart';
import 'package:boxi/model/rider.dart';
import 'package:flutter/material.dart';
import 'package:boxi/pages/reservation_details_page.dart';

class WidgetReservationItem extends StatelessWidget {
  final Reservation reservation;
  final Locker locker;
  final Locker? sourceLocker;
  final Delivery? delivery;
  final Rider rider;

  WidgetReservationItem(
      {required this.reservation,
      required this.locker,
      this.sourceLocker,
      this.delivery,
      required this.rider});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 2), blurRadius: 6.0)
            ]),
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
      child: Column(children: [
        _reservationStatus(reservation.status),
        const Divider(
          color: Colors.grey,
        ),
        const SizedBox(
          height: 10,
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
                  "ID",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
            Text(
              reservation.id,
              style: const TextStyle(fontSize: 14),
            )
          ],
        ),
        const SizedBox(
          height: 10,
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
                  "Date",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
            Text(
              reservation.startTime.toDate().toString().substring(0, 19),
              style: const TextStyle(fontSize: 14),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            textButton(
                const Row(
                  children: [
                    Text(
                      "Details ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                  ],
                ),
                Colors.black, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReservationDetailsPage(
                    reservation: reservation,
                    locker: locker,
                    sourceLocker: sourceLocker,
                    delivery: delivery,
                    rider: rider,
                    label: "Reservation Details",
                  ),
                ),
              );
            }),
          ],
        )
      ]),
    );
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

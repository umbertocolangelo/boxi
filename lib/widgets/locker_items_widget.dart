import 'package:boxi/model/box.dart';
import 'package:boxi/model/locker.dart';
import 'package:flutter/material.dart';
import 'package:boxi/pages/locker_details_page.dart';
import 'dart:math' show cos, sqrt, asin;

import 'package:google_maps_flutter/google_maps_flutter.dart';

class WidgetLockerItem extends StatelessWidget {
  final Locker locker;
  final List<Box> boxes;
  final LatLng pos;

  WidgetLockerItem(
      {required this.locker, required this.boxes, required this.pos});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute<LockerDetailsPage>(
                builder: (context) => LockerDetailsPage(
                      locker: locker,
                      boxes: boxes,
                      label: locker.name,
                    )));
      },
      child: Container(
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
          Text(
            locker.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              isAvailable(boxes)
                  ? const Icon(Icons.check, color: Colors.green)
                  : const Icon(Icons.clear, color: Colors.red),
              isAvailable(boxes)
                  ? Text(
                      "BOXES AVAILABLE",
                      style: TextStyle(fontSize: 16, color: Colors.green),
                    )
                  : Text(
                      "NO BOXES AVAILABLE",
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // riga con numero di box disponibili per ogni taglia
            children: [
              Column(
                children: [
                  Text(
                    "S",
                    style: TextStyle(fontSize: 8),
                  ),
                  Text(
                    availableBoxes(boxesForLocker(boxes, locker), "small")
                        .toString(),
                    style: TextStyle(fontSize: 8),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "M",
                    style: TextStyle(fontSize: 8),
                  ),
                  Text(
                    availableBoxes(boxesForLocker(boxes, locker), "medium")
                        .toString(),
                    style: TextStyle(fontSize: 8),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "L",
                    style: TextStyle(fontSize: 8),
                  ),
                  Text(
                    availableBoxes(boxesForLocker(boxes, locker), "large")
                        .toString(),
                    style: TextStyle(fontSize: 8),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "XL",
                    style: TextStyle(fontSize: 8),
                  ),
                  Text(
                    availableBoxes(boxesForLocker(boxes, locker), "extraLarge")
                        .toString(),
                    style: TextStyle(fontSize: 8),
                  ),
                ],
              ),
              //distanza dalla posizione dell'utente
              iconText(
                  const Icon(
                    Icons.location_on,
                    color: Colors.blue,
                  ),
                  Text(
                    calculateDistance(
                                pos.latitude,
                                pos.longitude,
                                locker.location.latitude,
                                locker.location.longitude)
                            .toStringAsFixed(2) +
                        " km",
                    style: TextStyle(
                        fontSize: 8,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<LockerDetailsPage>(
                        builder: (context) => LockerDetailsPage(
                              locker: locker,
                              boxes: boxes,
                              label: locker.name,
                            )));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Reserve a box",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                ],
              )),
        ]),
      ),
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

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  bool isAvailable(List<Box> boxes) {
    for (var box in boxes) {
      if (box.isAvailable == "true") {
        return true;
      }
    }
    return false;
  }

  //box available for each locker
  int availableBoxes(List<Box> boxes, String size) {
    int count = 0;
    for (var box in boxes) {
      if (box.isAvailable == "true" && box.size == size) {
        count++;
      }
    }
    return count;
  }

  //boxes for each locker
  List<Box> boxesForLocker(List<Box> boxes, Locker locker) {
    List<Box> boxesForLocker = [];
    for (var box in boxes) {
      if (box.lockerId == locker.id) {
        boxesForLocker.add(box);
      }
    }
    return boxesForLocker;
  }
}

import 'package:boxi/model/box.dart';
import 'package:boxi/model/locker.dart';
import 'package:boxi/widgets/appbar_widget.dart';
import 'package:boxi/widgets/bottom_bar_widget.dart';
import 'package:boxi/widgets/reservation_creation_widget.dart';
import 'package:flutter/material.dart';

class LockerDetailsPage extends StatefulWidget {
  final Locker locker;
  final List<Box> boxes;
  final String label;

  const LockerDetailsPage(
      {required this.locker,
      required this.boxes,
      required this.label,
      super.key});

  @override
  _LockerDetailsPageState createState() => _LockerDetailsPageState();
}

class _LockerDetailsPageState extends State<LockerDetailsPage> {
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
            child: _listView(context, widget.locker, widget.boxes),
          ),
          const Expanded(
            child: BottomBarWidget(),
          ),
        ],
      ),
    );
  }

  Widget _listView(BuildContext context, Locker locker, List<Box> boxes) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Image.network(
                  locker.picturePath,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  locker.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  isAvailable(boxes)
                      ? const Icon(Icons.check, color: Colors.green, size: 30)
                      : const Icon(Icons.clear, color: Colors.red, size: 30),
                  isAvailable(boxes)
                      ? const Text(
                          "BOXES AVAILABLE",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        )
                      : const Text(
                          "NO BOXES AVAILABLE",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // riga con numero di box disponibili per ogni taglia
                children: [
                  Column(
                    children: [
                      const Text(
                        "S",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        availableBoxes(boxesForLocker(boxes, locker), "small")
                            .toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "M",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        availableBoxes(boxesForLocker(boxes, locker), "medium")
                            .toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "L",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        availableBoxes(boxesForLocker(boxes, locker), "large")
                            .toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "XL",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        availableBoxes(
                                boxesForLocker(boxes, locker), "extraLarge")
                            .toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
            margin: const EdgeInsets.only(top: 10),
            child: ReservationCreationWidget(locker: locker, boxes: boxes)),
      ],
    );
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

  bool isAvailable(List<Box> boxes) {
    for (var box in boxes) {
      if (box.isAvailable == "true") {
        return true;
      }
    }
    return false;
  }
}

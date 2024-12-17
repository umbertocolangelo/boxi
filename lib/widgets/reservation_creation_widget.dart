import 'dart:math';

import 'package:boxi/controllers/box_controller.dart';
import 'package:boxi/controllers/delivery_controller.dart';
import 'package:boxi/controllers/reservation_controller.dart';
import 'package:boxi/model/box.dart';
import 'package:boxi/model/delivery.dart';
import 'package:boxi/model/locker.dart';
import 'package:boxi/model/reservation.dart';
import 'package:boxi/pages/after_reservation_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReservationCreationWidget extends StatefulWidget {
  final Locker locker;
  final List<Box> boxes;

  final List<String> lockerNames = [
    '-',
    'Ostbahnhof',
    'Alexanderplatz Bhf',
    'Friedrichstr. Bhf',
    'Zoologischer Garten Bhf',
    'Flughafen Berlin Brandenburg (BER)',
    'Berlin Hauptbahnhof',
    'Tiergarten Bhf',
    'Warschauer Str. Bhf ',
  ];
  final List<String> lockerIds = ['-', '2', '1', '4', '6', '8', '3', '5', '7'];

  final List<String> deliveryTimes = [
    '-',
    '30 min',
    '1h',
    '2h',
    '3h',
    '6',
    '9h',
    '12h',
    '24h'
  ];

  ReservationCreationWidget(
      {super.key, required this.locker, required this.boxes});

  @override
  _ReservationCreationWidgetState createState() =>
      _ReservationCreationWidgetState();
}

class _ReservationCreationWidgetState extends State<ReservationCreationWidget> {
  final _formKey = GlobalKey<FormState>();

  int availableBoxes(String lockerId, List<Box> boxes, String size) {
    int count = 0;
    if (lockerId != '-') {
      for (var box in boxes) {
        if (box.lockerId == lockerId &&
            box.isAvailable == "true" &&
            box.size == size) {
          count++;
        }
      }
    }
    return count;
  }

  bool possibleDestinationLocker(String lockerId, String size) {
    switch (size) {
      case 'Small':
        if (availableBoxes(lockerId, widget.boxes, 'small') > 0) {
          return true;
        }
        break;
      case 'Medium':
        if (availableBoxes(lockerId, widget.boxes, 'medium') > 0) {
          return true;
        }
        break;
      case 'Large':
        if (availableBoxes(lockerId, widget.boxes, 'large') > 0) {
          return true;
        }
        break;
      case 'Extra Large':
        if (availableBoxes(lockerId, widget.boxes, 'extraLarge') > 0) {
          return true;
        }
        break;
    }
    return false;
  }

  // Available box sizes
  List<String> boxSizes = ['-'];
  String selectedBoxSize = '-';

  // Available durations
  List<String> timeDurations = [
    '-',
    '30 min',
    '1h',
    '2h',
    '3h',
    '6h',
    '9h',
    '12h',
    '24h'
  ];
  String selectedTimeDuration = '-';

  // Available destination lockers and delivery times
  List<String> availableDestinationLockers = [];
  List<String> availableDeliveryTimes = [];
  String selectedDeliveryTime = '-';
  String selectedDestinationLocker = '-';

  bool delivery = false;

  @override
  void initState() {
    int availableSmallBoxes =
        availableBoxes(widget.locker.id, widget.boxes, 'small');
    int availableMediumBoxes =
        availableBoxes(widget.locker.id, widget.boxes, 'medium');
    int availableLargeBoxes =
        availableBoxes(widget.locker.id, widget.boxes, 'large');
    int availableExtraLargeBoxes =
        availableBoxes(widget.locker.id, widget.boxes, 'extraLarge');
    if (availableSmallBoxes != 0) {
      boxSizes.add('Small');
    }
    if (availableMediumBoxes != 0) {
      boxSizes.add('Medium');
    }
    if (availableLargeBoxes != 0) {
      boxSizes.add('Large');
    }
    if (availableExtraLargeBoxes != 0) {
      boxSizes.add('Extra Large');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildBoxSize(),
          _buildDuration(),
          if (selectedTimeDuration != '-' &&
              selectedTimeDuration != '30 min' &&
              selectedBoxSize != '-')
            _buildDelivery(),
          if (selectedTimeDuration != '-' &&
              selectedBoxSize != '-' &&
              (!delivery ||
                  (delivery &&
                      selectedDestinationLocker != '-' &&
                      selectedDeliveryTime != '-')))
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: _buildSubmitButton(),
            ),
        ],
      ),
    );
  }

  Widget _buildBoxSize() {
    return Column(children: [
      const Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Text(
          'Which box size do you need?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          value: selectedBoxSize,
          items: boxSizes.map((boxSize) {
            return DropdownMenuItem(
              value: boxSize,
              child: Text('$boxSize'),
            );
          }).toList(),
          onChanged: (val) {
            setState(() {
              selectedBoxSize = val.toString();
            });
          },
        ),
      ),
    ]);
  }

  Widget _buildDuration() {
    return Column(children: [
      const Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Text(
          'For how long?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          value: selectedTimeDuration,
          items: timeDurations.map((timeDuration) {
            return DropdownMenuItem(
              value: timeDuration,
              child: Text('$timeDuration'),
            );
          }).toList(),
          onChanged: (val) {
            setState(() {
              selectedTimeDuration = val.toString();
            });
          },
        ),
      ),
    ]);
  }

//build a widget where the user can choose if he wants the delivery or not, if yes the details appear
  Widget _buildDelivery() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            'Do you want to deliver your box to another locker?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            children: [
              Radio(
                value: false,
                groupValue: delivery,
                onChanged: (value) {
                  setState(() {
                    delivery = value as bool;
                  });
                },
              ),
              const Text('No',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            children: [
              Radio(
                value: true,
                groupValue: delivery,
                onChanged: (value) {
                  setState(() {
                    delivery = value as bool;
                    availableDestinationLockers = widget.lockerNames
                        .where((element) =>
                            element != widget.locker.name &&
                            possibleDestinationLocker(
                                widget.lockerIds[
                                    widget.lockerNames.indexOf(element)],
                                selectedBoxSize))
                        .toList();
                    availableDestinationLockers.insert(0, '-');
                    availableDeliveryTimes = timeDurations.sublist(
                        0, timeDurations.indexOf(selectedTimeDuration));
                  });
                },
              ),
              const Text('Yes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        if (delivery == true) _buildDeliveryDetails()
      ],
    );
  }

//build a widget where the user can insert the delivery details: destination locker, delivery time
  Widget _buildDeliveryDetails() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text('Where do you want to pick up your box?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            value: selectedDestinationLocker,
            items: availableDestinationLockers.map((destinationLocker) {
              return DropdownMenuItem(
                value: destinationLocker,
                child: Text('$destinationLocker'),
              );
            }).toList(),
            onChanged: (val) {
              setState(() {
                selectedDestinationLocker = val.toString();
              });
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text('When do you want to pick up your box?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            value: selectedDeliveryTime,
            items: availableDeliveryTimes.map((deliveryTime) {
              return DropdownMenuItem(
                value: deliveryTime,
                child: Text('$deliveryTime'),
              );
            }).toList(),
            onChanged: (val) {
              setState(() {
                selectedDeliveryTime = val.toString();
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    Reservation reservation = Reservation(
      id: '',
      lockerId: '',
      customerId: '',
      boxId: '',
      deliveryId: '',
      startTime: Timestamp.fromDate(DateTime.now()),
      endTime: Timestamp.fromDate(DateTime.now()),
      cost: 0,
      status: '',
    );
    return ElevatedButton(
      //style
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Confirm Reservation ",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Icon(
            Icons.check,
            color: Colors.white,
          ),
        ],
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          if (delivery == true) {
            reservation = Reservation(
              id: generateRandomId(), //reservationId
              lockerId: widget.locker.id,
              customerId: '1',
              boxId: getBoxIdBySizeByLocker(
                  widget.boxes, convSize(selectedBoxSize), widget.locker.id),
              deliveryId: generateRandomId(), //deliveryId
              startTime: Timestamp.fromDate(DateTime.now()), //start time
              //end time
              endTime: Timestamp.fromDate(DateTime.now().add(Duration(
                  minutes: convTime(selectedDeliveryTime)))), //delivery time
              cost: calculateCost(
                  selectedBoxSize, selectedTimeDuration, true), //price, //price
              status: 'active', //status
            );
            ReservationController().addReservation(reservation.toJson());
            //update box
            Box box = boxIsOccupied(reservation.boxId,
                widget.boxes); //box is occupied by reservation
            Delivery delivery = Delivery(
              id: reservation.deliveryId!,
              boxId: reservation.boxId,
              customerId: reservation.customerId,
              riderId: '1',
              fromLockerId: reservation.lockerId,
              toLockerId: widget.lockerIds[
                  widget.lockerNames.indexOf(selectedDestinationLocker)],
              deliveryDate: Timestamp.fromDate(DateTime.now()),
              withinTime: Timestamp.fromDate(DateTime.now().add(Duration(
                  minutes: convTime(selectedDeliveryTime)))),
              isDelivered: false,
              status: 'active',
            );
            DeliveryController().addDelivery(delivery.toJson());
            //update box
            box = moveBoxToLockerAndOccupied(
                reservation.boxId,
                widget.lockerIds[
                    widget.lockerNames.indexOf(selectedDestinationLocker)],
                widget.boxes);
            if (box.id != '') {
              BoxController boxController = BoxController();
              boxController.updateBox(reservation.boxId, box.toJson()); //update box
            }
          } else {
            //no delivery
            reservation = Reservation(
              id: generateRandomId(), //reservationId
              lockerId: widget.locker.id,
              customerId: '1',
              boxId: getBoxIdBySizeByLocker(
                  widget.boxes, convSize(selectedBoxSize), widget.locker.id),
              deliveryId: null, //deliveryId
              startTime: Timestamp.fromDate(DateTime.now()), //start time
              //end time
              endTime: Timestamp.fromDate(DateTime.now().add(Duration(
                  minutes: convTime(selectedTimeDuration)))), //delivery time
              cost: calculateCost(
                  selectedBoxSize, selectedTimeDuration, false), //price
              status: 'active', //status
            );
            ReservationController().addReservation(reservation.toJson());
            //update box
            Box box = boxIsOccupied(reservation.boxId, widget.boxes);
            if (box.id != '') {
              BoxController boxController = BoxController();
              boxController.updateBox(
                  reservation.boxId, box.toJson()); //update box
            }
          }
          //go to direction page
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AfterReservationPage(
                    label: 'Reservation Confirmed',
                    locker: widget.locker,
                    
                    reservation: reservation),
              ));
        }
      },
    );
  }

  String generateRandomId({int length = 8}) {
    const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();

    String randomId = '';

    for (int i = 0; i < length; i++) {
      randomId += characters[random.nextInt(characters.length)];
    }

    return randomId;
  }

  String getBoxIdBySizeByLocker(List<Box> boxes, String size, String lockerId) {
    // Find the box with the specified size and locker ID
    Box? foundBox = boxes.firstWhere(
        (box) => box.size == size && box.lockerId == lockerId,
        orElse: () =>
            Box(id: '', lockerId: '', size: '', isAvailable: '', isOffer: ''));

    return foundBox.id; // Return an empty string if not found
  }

  Box getBoxById(String boxId, List<Box> boxes) {
    // Find the box with the specified ID
    Box? foundBox = boxes.firstWhere((box) => box.id == boxId,
        orElse: () =>
            Box(id: '', lockerId: '', size: '', isAvailable: '', isOffer: ''));

    return foundBox; // Return an empty Box if not found
  }

  Box boxIsOccupied(String boxId, List<Box> boxes) {
    Box box = getBoxById(boxId, boxes);
    box.isAvailable = 'false';

    return box;
  }

  Box moveBoxToLockerAndOccupied(String boxId, String lockerId, List<Box> boxes) {
    Box box = getBoxById(boxId, boxes);
    box.isAvailable = 'false';
    box.lockerId = lockerId;

    return box;
  }

  String convSize(String s) {
    switch (s) {
      case 'Small':
        return 'small';
      case 'Medium':
        return 'medium';
      case 'Large':
        return 'large';
      case 'Extra Large':
        return 'extraLarge';
      default:
        return '';
    }
  }

  //time conversion in minutes
  int convTime(String s) {
    switch (s) {
      case '30 min':
        return 30;
      case '1h':
        return 60;
      case '2h':
        return 120;
      case '3h':
        return 180;
      case '6h':
        return 360;
      case '9h':
        return 540;
      case '12h':
        return 720;
      case '24h':
        return 1440;
      default:
        return 0;
    }
  }

  double calculateCost(String size, String duration, bool delivery) {
    double sizeCoeff = 0;
    double durationCoeff = 0;
    double cost = 0;

    switch (size) {
      case 'Small':
        sizeCoeff = 1;
        break;
      case 'Medium':
        sizeCoeff = 1.5;
        break;
      case 'Large':
        sizeCoeff = 1.75;
        break;
      case 'Extra Large':
        sizeCoeff = 1.9;
        break;
    }

    switch (duration) {
      case '30 min':
        durationCoeff = 0.8;
        break;
      case '1h':
        durationCoeff = 1.2;
        break;
      case '2h':
        durationCoeff = 1.45;
        break;
      case '3h':
        durationCoeff = 1.75;
        break;
      case '6h':
        durationCoeff = 2;
        break;
      case '9h':
        durationCoeff = 2.2;
        break;
      case '12h':
        durationCoeff = 2.35;
        break;
      case '24h':
        durationCoeff = 2.5;
        break;
    }

    cost = sizeCoeff * durationCoeff;

    if (delivery) {
      cost += 1.5;
    }

    if (cost < 2) {
      cost = 2;
    }

    return cost;
  }
}

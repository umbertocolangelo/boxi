import 'dart:async';

import 'package:boxi/controllers/box_controller.dart';
import 'package:boxi/controllers/locker_controller.dart';
import 'package:boxi/model/box.dart';
import 'package:boxi/model/locker.dart';
import 'package:boxi/widgets/appbar_widget.dart';
import 'package:boxi/widgets/bottom_bar_widget.dart';
import 'package:boxi/widgets/locker_items_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:math' show cos, sqrt, asin;

class ListPage extends StatefulWidget {
  final String label;
  const ListPage({required this.label, super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Location _locationController = new Location();

  LatLng? _currentP = null;

  LatLng FMP = LatLng(52.513192, 13.438127);

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    LockerController lockerController = LockerController();
    BoxController boxController = BoxController();
    return Container(
      padding: const EdgeInsets.all(0),
      child: FutureBuilder(
          future: Future.wait(
              [lockerController.fetchLockers(), boxController.fetchBoxes()]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Scaffold(
                  body: Column(children: [
                    Expanded(flex: 1, child: AppBarWidget(label: widget.label)),
                    Expanded(
                      flex: 7,
                      child: _listView(
                          context,
                          snapshot.data?[0] as List<Locker>,
                          snapshot.data?[1] as List<Box>,
                          _currentP),
                    ),
                    Expanded(
                      child: BottomBarWidget(),
                    ),
                  ]),
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
          }),
    );
  }

  Widget _listView(BuildContext context, List<Locker> lockers, List<Box> boxes,
      LatLng? pos) {
    return ListView(
      padding: const EdgeInsets.all(5),
      children: [
        ListView.builder(
          itemCount: lockers.length,
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0)),
              child: WidgetLockerItem(
                  locker: sortLockersByDistance(lockers, pos ?? FMP)[index],
                  boxes: boxes,
                  pos: pos ?? FMP),
            );
          },
        )
      ],
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
      }
    });
  }

  //locker mostrati in base alla distanza
  List<Locker> sortLockersByDistance(List<Locker> lockers, LatLng pos) {
    List<Locker> sortedLockers = [];
    for (var locker in lockers) {
      sortedLockers.add(locker);
    }
    sortedLockers.sort((a, b) => calculateDistance(pos.latitude, pos.longitude,
            a.location.latitude, a.location.longitude)
        .compareTo(calculateDistance(pos.latitude, pos.longitude,
            b.location.latitude, b.location.longitude)));
    return sortedLockers;
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}

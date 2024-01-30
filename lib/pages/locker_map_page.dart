import 'dart:async';

import 'package:boxi/controllers/box_controller.dart';
import 'package:boxi/controllers/locker_controller.dart';
import 'package:boxi/model/box.dart';
import 'package:boxi/model/locker.dart';
import 'package:boxi/pages/direction_page.dart';
import 'package:boxi/widgets/appbar_widget.dart';
import 'package:boxi/widgets/locker_items_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:boxi/widgets/bottom_bar_widget.dart';

class MapPage extends StatefulWidget {
  final String label;
  const MapPage({required this.label, super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location _locationController = new Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const FMP = LatLng(52.513192, 13.438127);
  LatLng? _currentP = null;

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    addCustomIcon();
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
                      child: _mapView(
                          context,
                          snapshot.data?[0] as List<Locker>,
                          snapshot.data?[1] as List<Box>,
                          _currentP),
                    ),
                    const Expanded(
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

  Widget _mapView(BuildContext context, List<Locker> lockers, List<Box> boxes,
      LatLng? currentP) {
    Set<Marker> markers = {};
    return _currentP == null
        ? Center(
            child: SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(
              strokeWidth: 5,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.black.withOpacity(0.5)),
            ),
          ))
        : Stack(
            children: [
              GoogleMap(
                myLocationEnabled: true,
                //trafficEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: currentP!,
                  zoom: 13,
                ),
                markers: markers
                  ..addAll(
                    lockers.map(
                      (locker) => Marker(
                        markerId: MarkerId(locker.id),
                        position: LatLng(locker.location.latitude,
                            locker.location.longitude),
                        icon: markerIcon,
                        onTap: () {
                          _showLockerDetails(context, locker, boxes);
                        },
                      ),
                    ),
                  ),
                onMapCreated: ((GoogleMapController controller) =>
                    _mapController.complete(controller)),
              ),
            ],
          );
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(), 'assets/images/locker_icon.png')
        .then((icon) {
      setState(() {
        markerIcon = icon;
      });
    });
  }

  void _showLockerDetails(
      BuildContext context, Locker locker, List<Box> boxes) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              contentPadding: const EdgeInsets.all(5),
              insetPadding: const EdgeInsets.all(5),
              actions: [
                //button to get directions to the locker
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DirectionsPage(
                                label: 'Directions',
                                lockerLocation: LatLng(locker.location.latitude,
                                    locker.location.longitude))),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Get directions ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.directions,
                          color: Colors.white,
                        ),
                      ],
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ))),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Close",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ],
                    )),
              ],
              content: WidgetLockerItem(
                  locker: locker, boxes: boxes, pos: _currentP ?? FMP),
            ),
          ],
        );
      },
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
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
          _cameraToPosition(_currentP!);
        });
      }
    });
  }
}

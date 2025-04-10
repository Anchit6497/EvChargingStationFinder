import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_application_1/const.dart'; // Make sure you have this file with your API key
import 'package:cloud_firestore/cloud_firestore.dart';

class MapPage extends StatefulWidget {
  final DocumentSnapshot doc;

  const MapPage({super.key, required this.doc});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Location _locationController = Location();
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  late LatLng _pGooglePlex; // Will be initialized in initState
  LatLng? _currentP;
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    // Initialize _pGooglePlex with latitude and longitude from the Firestore document
    _pGooglePlex = LatLng(widget.doc['latitude'], widget.doc['longitude']);
    getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentP == null
          ? const Center(child: Text("Loading..."))
          : GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
              initialCameraPosition: CameraPosition(
                target: _pGooglePlex,
                zoom: 20,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("_sourceLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _pGooglePlex,
                ),
                if (_currentP != null)
                  Marker(
                    markerId: const MarkerId("_currentLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _currentP!,
                  ),
              },
              polylines: _polylines,
            ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );

    await controller.animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          _currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentP!);
        });
        getPolylinePoints();
      }
    });
  }

  Future<void> getPolylinePoints() async {
    if (_currentP == null) return;

    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: GOOGLE_MAPS_API_KEY,
      request: PolylineRequest(
        origin: PointLatLng(_currentP!.latitude, _currentP!.longitude),
        destination: PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      for (PointLatLng point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      setState(() {
        _polylines.add(Polyline(
          polylineId: const PolylineId("route"),
          points: polylineCoordinates,
          color: Colors.blue,
          width: 5,
        ));
      });
    } else {
      print(result.errorMessage);
    }
  }
}

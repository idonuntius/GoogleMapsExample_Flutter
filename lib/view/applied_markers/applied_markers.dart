import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_example_flutter/model/location.dart';
import 'package:google_maps_example_flutter/model/sample_data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppliedMarkers extends StatelessWidget {
  static const routeName = 'AppliedMarkers';
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => const AppliedMarkers(),
    );
  }

  const AppliedMarkers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('マーカーの応用'),
      ),
      body: _Main(),
    );
  }
}

class _Main extends StatefulWidget {
  @override
  __MainState createState() => __MainState();
}

class __MainState extends State<_Main> {
  final _markers = <Marker>{};
  final _markerId = const MarkerId('markerId');
  int _currentLocationsDataIndex = 0;
  GoogleMapController? _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        markerId: _markerId,
        position: LatLng(
          locationsData[_currentLocationsDataIndex].coordinates.latitude,
          locationsData[_currentLocationsDataIndex].coordinates.longitude,
        ),
      ),
    );
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _currentLocationsDataIndex++;
      if (_currentLocationsDataIndex > locationsData.length - 1) _currentLocationsDataIndex = 0;
      final location = locationsData[_currentLocationsDataIndex];
      _updateMarker(location);
      _animateCamera(location);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(
          locationsData[_currentLocationsDataIndex].coordinates.latitude,
          locationsData[_currentLocationsDataIndex].coordinates.longitude,
        ),
        zoom: 15,
      ),
      markers: _markers,
      onMapCreated: (controller) {
        _controller = controller;
      },
    );
  }

  _updateMarker(final Location location) {
    _markers.removeWhere((marker) => marker.markerId == _markerId);
    setState(() {
      _markers.add(
        Marker(
          markerId: _markerId,
          position: LatLng(
            location.coordinates.latitude,
            location.coordinates.longitude,
          ),
        ),
      );
    });
  }

  _animateCamera(final Location location) {
    final cameraUpdate = CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(
          location.coordinates.latitude,
          location.coordinates.longitude,
        ),
        zoom: 15,
      ),
    );
    _controller?.animateCamera(cameraUpdate);
  }
}

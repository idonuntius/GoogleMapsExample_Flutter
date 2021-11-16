import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_maps_example_flutter/model/sample_data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonPage extends StatefulWidget {
  static const routeName = 'Polygon';
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => const PolygonPage(),
    );
  }

  const PolygonPage({Key? key}) : super(key: key);

  @override
  _PolygonPageState createState() => _PolygonPageState();
}

class _PolygonPageState extends State<PolygonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ポリゴン'),
      ),
      body: _Main(),
    );
  }
}

class _Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(
          locationsData.first.coordinates.latitude,
          locationsData.first.coordinates.longitude,
        ),
        zoom: 13.0,
      ),
      polygons: {_polygon},
      onMapCreated: (controller) {
        final bounds = CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(
              locationsData.map((location) => location.coordinates.latitude).min,
              locationsData.map((location) => location.coordinates.longitude).min,
            ),
            northeast: LatLng(
              locationsData.map((location) => location.coordinates.latitude).max,
              locationsData.map((location) => location.coordinates.longitude).max,
            ),
          ),
          48,
        );
        controller.animateCamera(bounds);
      },
    );
  }

  Polygon get _polygon => Polygon(
        polygonId: const PolygonId('polygonId'),
        strokeColor: Colors.red,
        strokeWidth: 8,
        fillColor: Colors.red.withOpacity(0.15),
        points: locationsData
            .map((location) => LatLng(location.coordinates.latitude, location.coordinates.longitude))
            .toList(),
      );
}

extension DoubleIterableExtension on Iterable<double> {
  double get max => reduce(math.max);
  double get min => reduce(math.min);
}

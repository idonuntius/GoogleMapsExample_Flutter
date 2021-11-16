import 'package:flutter/material.dart';
import 'package:google_maps_example_flutter/model/sample_data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CirclePage extends StatefulWidget {
  static const routeName = 'Circle';
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => const CirclePage(),
    );
  }

  const CirclePage({Key? key}) : super(key: key);

  @override
  _CirclePageState createState() => _CirclePageState();
}

class _CirclePageState extends State<CirclePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('サークル'),
      ),
      body: _Main(),
    );
  }
}

class _Main extends StatelessWidget {
  _Main();

  final location = locationsData.first;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(location.coordinates.latitude, location.coordinates.longitude),
        zoom: 17.0,
      ),
      circles: {_circle},
    );
  }

  Circle get _circle => Circle(
        circleId: const CircleId('circleId'),
        strokeColor: Colors.red,
        strokeWidth: 8,
        radius: 1000,
        fillColor: Colors.red.withOpacity(0.15),
        center: LatLng(location.coordinates.latitude, location.coordinates.longitude),
      );
}

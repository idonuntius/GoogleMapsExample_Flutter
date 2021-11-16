import 'package:flutter/material.dart';
import 'package:google_maps_example_flutter/model/coordinates.dart';
import 'package:google_maps_example_flutter/model/location.dart';
import 'package:google_maps_example_flutter/model/sample_data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppliedMarkersAndPolyline extends StatelessWidget {
  static const routeName = 'AppliedMarkersAndPolyline';
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => const AppliedMarkersAndPolyline(),
    );
  }

  const AppliedMarkersAndPolyline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('マーカー + ポリラインの応用'),
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
  late Marker _marker1;
  late Marker _marker2;
  late Polyline _polyline;
  late LatLng _currentLatLng;

  @override
  void initState() {
    super.initState();

    final location = locationsData.first;
    _setMarker1(location);
    _setMarker2(location.coordinates.toLatLng());
    _setPolyline();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(
          locationsData.first.coordinates.latitude,
          locationsData.first.coordinates.longitude,
        ),
        zoom: 15,
      ),
      rotateGesturesEnabled: false,
      zoomGesturesEnabled: false,
      markers: {_marker1, _marker2},
      polylines: {_polyline},
      onCameraMove: (position) {
        setState(() {
          _setMarker2(position.target);
          _setPolyline();
        });
      },
    );
  }

  _setMarker1(final Location location) {
    _marker1 = Marker(
      markerId: const MarkerId('markerId'),
      position: location.coordinates.toLatLng(),
    );
  }

  _setMarker2(final LatLng latLang) {
    _marker2 = Marker(
      markerId: MarkerId(latLang.hashCode.toString()),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      position: latLang,
    );
  }

  _setPolyline() {
    _polyline = Polyline(
      polylineId: const PolylineId('polylineId'),
      color: Colors.blue.shade300,
      width: 4,
      patterns: [PatternItem.dash(20), PatternItem.gap(15)],
      points: [_marker1.position, _marker2.position],
    );
  }
}

extension CoordinatesExtension on Coordinates {
  LatLng toLatLng() => LatLng(latitude, longitude);
}

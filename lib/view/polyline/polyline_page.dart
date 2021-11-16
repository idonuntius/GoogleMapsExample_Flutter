import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_example_flutter/model/sample_data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum _PolylineType {
  normal,
  dottedLine,
}

extension _PolylineTypeExtension on _PolylineType {
  String toLocalString() {
    switch (this) {
      case _PolylineType.normal:
        return 'ノーマル';
      case _PolylineType.dottedLine:
        return '点線';
    }
  }
}

class PolylinePage extends StatefulWidget {
  static const routeName = 'Polyline';
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => const PolylinePage(),
    );
  }

  const PolylinePage({Key? key}) : super(key: key);

  @override
  _PolylinePageState createState() => _PolylinePageState();
}

class _PolylinePageState extends State<PolylinePage> {
  var _polylineType = _PolylineType.normal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ポリラインの種類'),
        actions: [
          IconButton(
            icon: const Icon(Icons.android),
            onPressed: _showBottomSheet,
          ),
        ],
      ),
      body: _Main(_polylineType),
    );
  }

  _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: _PolylineType.values
              .map<Widget>(
                (type) => RadioListTile(
                  title: Text(type.toLocalString()),
                  value: type,
                  groupValue: _polylineType,
                  onChanged: (_) {
                    setState(() => _polylineType = type);
                    Navigator.of(context).pop();
                  },
                ),
              )
              .toList()
            ..add(const SafeArea(child: SizedBox.shrink(), bottom: true)),
        );
      },
    );
  }
}

class _Main extends StatelessWidget {
  _Main(this._polylineType);

  final _PolylineType _polylineType;
  final _location1 = locationsData.first;
  final _location2 = locationsData[1];

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(_location1.coordinates.latitude, _location1.coordinates.longitude),
        zoom: 13.0,
      ),
      polylines: {
        _polyline,
      },
      onMapCreated: (controller) {
        final bounds = CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(
              min(_location1.coordinates.latitude, _location2.coordinates.latitude),
              min(_location1.coordinates.longitude, _location2.coordinates.longitude),
            ),
            northeast: LatLng(
              max(_location1.coordinates.latitude, _location2.coordinates.latitude),
              max(_location1.coordinates.longitude, _location2.coordinates.longitude),
            ),
          ),
          48,
        );
        controller.animateCamera(bounds);
      },
    );
  }

  Polyline get _polyline => Polyline(
        polylineId: const PolylineId('polylineId'),
        width: 4,
        color: Colors.red,
        patterns: _polylineType == _PolylineType.dottedLine
            ? [
                PatternItem.dash(20),
                PatternItem.gap(10),
              ]
            : [],
        points: [
          LatLng(_location1.coordinates.latitude, _location1.coordinates.longitude),
          LatLng(_location2.coordinates.latitude, _location2.coordinates.longitude),
        ],
      );
}

import 'package:flutter/material.dart';
import 'package:google_maps_example_flutter/model/sample_data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum _MarkerType {
  normal,
  otherColor,
  image,
  infoWindow,
  multiple,
}

extension _MarkerTypeExtension on _MarkerType {
  String toLocalString() {
    switch (this) {
      case _MarkerType.normal:
        return 'ノーマル';
      case _MarkerType.otherColor:
        return '色';
      case _MarkerType.image:
        return '画像';
      case _MarkerType.infoWindow:
        return '吹き出し';
      case _MarkerType.multiple:
        return '複数';
    }
  }
}

class MarkerTypePage extends StatefulWidget {
  static const routeName = 'Mark';
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => const MarkerTypePage(),
    );
  }

  const MarkerTypePage({Key? key}) : super(key: key);

  @override
  _MarkterTypePageState createState() => _MarkterTypePageState();
}

class _MarkterTypePageState extends State<MarkerTypePage> {
  var _markerType = _MarkerType.normal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('マップの種類'),
        actions: [
          IconButton(
            icon: const Icon(Icons.android),
            onPressed: _showBottomSheet,
          ),
        ],
      ),
      body: _Main(_markerType),
    );
  }

  _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: _MarkerType.values
              .map<Widget>(
                (type) => RadioListTile(
                  title: Text(type.toLocalString()),
                  value: type,
                  groupValue: _markerType,
                  onChanged: (_) {
                    setState(() => _markerType = type);
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
  _Main(this._markerType);

  final _MarkerType _markerType;
  final location = locationsData.first;

  @override
  Widget build(BuildContext context) {
    return _buildMap();
  }

  Widget _buildMap() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(location.coordinates.latitude, location.coordinates.longitude),
        zoom: 13.0,
      ),
      markers: markers,
    );
  }

  Set<Marker> get markers {
    switch (_markerType) {
      case _MarkerType.normal:
        final location = locationsData.first;
        return {
          Marker(
            markerId: MarkerId(location.hashCode.toString()),
            position: LatLng(location.coordinates.latitude, location.coordinates.longitude),
          ),
        };
      case _MarkerType.otherColor:
        final location = locationsData.first;
        return {
          Marker(
            markerId: MarkerId(location.hashCode.toString()),
            position: LatLng(location.coordinates.latitude, location.coordinates.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        };
      case _MarkerType.infoWindow:
        final location = locationsData.first;
        return {
          Marker(
            markerId: MarkerId(location.hashCode.toString()),
            position: LatLng(location.coordinates.latitude, location.coordinates.longitude),
            infoWindow: const InfoWindow(title: 'タイトル', snippet: 'スニペット'),
          ),
        };
      case _MarkerType.multiple:
        return {
          Marker(
            markerId: MarkerId(locationsData.first.hashCode.toString()),
            position: LatLng(locationsData.first.coordinates.latitude, locationsData.first.coordinates.longitude),
          ),
          Marker(
            markerId: MarkerId(locationsData[1].hashCode.toString()),
            position: LatLng(locationsData[1].coordinates.latitude, locationsData[1].coordinates.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        };
      case _MarkerType.image:
        final location = locationsData.first;
        return {
          Marker(
            markerId: MarkerId(location.hashCode.toString()),
            position: LatLng(location.coordinates.latitude, location.coordinates.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        };
    }
  }
}

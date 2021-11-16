import 'package:flutter/material.dart';
import 'package:google_maps_example_flutter/model/sample_data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTypePage extends StatefulWidget {
  static const routeName = 'MapType';
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => const MapTypePage(),
    );
  }

  const MapTypePage({Key? key}) : super(key: key);

  @override
  _MapTypePageState createState() => _MapTypePageState();
}

class _MapTypePageState extends State<MapTypePage> {
  var _mapType = MapType.normal;

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
      body: _Main(_mapType),
    );
  }

  _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: MapType.values
              .map<Widget>(
                (type) => RadioListTile(
                  title: Text(type.toString()),
                  value: type,
                  groupValue: _mapType,
                  onChanged: (_) {
                    setState(() => _mapType = type);
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
  _Main(this._mapType);

  final MapType _mapType;
  final location = locationsData.first;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: _mapType,
      initialCameraPosition: CameraPosition(
        target: LatLng(
          location.coordinates.latitude,
          location.coordinates.longitude,
        ),
        zoom: 15,
      ),
    );
  }
}

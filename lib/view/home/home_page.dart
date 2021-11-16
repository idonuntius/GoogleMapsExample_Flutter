import 'package:flutter/material.dart';
import 'package:google_maps_example_flutter/view/applied_markers/applied_markers.dart';
import 'package:google_maps_example_flutter/view/applied_markers_and_polyline/applied_markers_and_polyline.dart';
import 'package:google_maps_example_flutter/view/circle/circle_page.dart';
import 'package:google_maps_example_flutter/view/map_type/map_type_page.dart';
import 'package:google_maps_example_flutter/view/marker_type/marker_type_page.dart';
import 'package:google_maps_example_flutter/view/polygon/polygon_page.dart';
import 'package:google_maps_example_flutter/view/polyline/polyline_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
      ),
      body: ListView(
        children: [
          _ListItem(
            title: 'マップの種類',
            onTap: () => Navigator.of(context).push(MapTypePage.route()),
          ),
          _ListItem(
            title: 'マーカーの種類',
            onTap: () => Navigator.of(context).push(MarkerTypePage.route()),
          ),
          _ListItem(
            title: 'ポリラインの種類',
            onTap: () => Navigator.of(context).push(PolylinePage.route()),
          ),
          _ListItem(
            title: 'ポリゴン',
            onTap: () => Navigator.of(context).push(PolygonPage.route()),
          ),
          _ListItem(
            title: 'サークル',
            onTap: () => Navigator.of(context).push(CirclePage.route()),
          ),
          _ListItem(
            title: 'マーカーの応用',
            onTap: () => Navigator.of(context).push(AppliedMarkers.route()),
          ),
          _ListItem(
            title: 'マーカー + ポリラインの応用',
            onTap: () => Navigator.of(context).push(AppliedMarkersAndPolyline.route()),
          ),
        ],
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({Key? key, required this.title, required this.onTap}) : super(key: key);

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward),
          onTap: onTap,
        ),
        const Divider(height: 1),
      ],
    );
  }
}

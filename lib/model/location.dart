import 'package:google_maps_example_flutter/model/coordinates.dart';

class Location {
  const Location({
    required this.id,
    required this.name,
    required this.coordinates,
  });

  final int id;
  final String name;
  final Coordinates coordinates;
}

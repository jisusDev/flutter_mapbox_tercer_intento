import 'package:flutter_map/flutter_map.dart';


List<Marker> pokemonMarkers = [];

class MapService {
  static const String mapboxAccesToken =
      "pk.eyJ1IjoiY2FydmFqYWxtYXJpZWxzeSIsImEiOiJjbHZyOWdkZGEwa2JlMmttZzNuZ2V3Nm52In0.XzknMqNCOBNtUgnHKvCHhg";

  static TileLayer getTileLayerOptions() {
    return TileLayer(
      urlTemplate:
          'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=$mapboxAccesToken',
      additionalOptions: const {
        "id": "mapbox/streets-v12",
      },
    );
  }

  static TileLayer getDarkTileLayerOptions() {
    return TileLayer(
      urlTemplate:
          'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=$mapboxAccesToken',
      additionalOptions: const {
        "id": "mapbox/dark-v11",
      },
    );
  }
}



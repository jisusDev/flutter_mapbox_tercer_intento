import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mapbox_tercer_intento/model/model_pokemon.dart';
import 'package:latlong2/latlong.dart';

LatLngBounds mapBounds = LatLngBounds(
  // const LatLng(4.6, -74.1),
  // const LatLng(4.8, -73.9),
  const LatLng(4.700014, -74.04212),
  const LatLng(4.703560, -74.038597),
);

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

  static MarkerLayer getMarkerLayerOptions(
      BuildContext context, List<PokemonModel> pokemons) {
    return MarkerLayer(
      rotate: true,
      markers: pokemons.map((pokemon) {
        if (pokemon.lat == null || pokemon.lng == null) {
          pokemon.lat = mapBounds.southEast.latitude +
              Random().nextDouble() *
                  (mapBounds.northEast.latitude - mapBounds.southEast.latitude);
          pokemon.lng = mapBounds.southWest.longitude +
              Random().nextDouble() *
                  (mapBounds.northEast.longitude -
                      mapBounds.southWest.longitude);
        }

        return Marker(
          height: 70,
          width: 70,
          point: LatLng(pokemon.lat!, pokemon.lng!),
          // point: const LatLng(4.700014, -74.042124),
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 400,
                    width: double.infinity,
                    color: Colors.white,
                    child: const Text("Bottom sheet successful"),
                  );
                },
              );
            },
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(66, 158, 158, 158),
              child: Image.network(
                pokemon.image ?? '',
                width: 120,
                height: 80,
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

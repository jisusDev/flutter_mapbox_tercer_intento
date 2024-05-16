import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mapbox_tercer_intento/model/model_pokemon.dart';
import 'package:flutter_mapbox_tercer_intento/model/pokemon_detail_model.dart';
import 'package:flutter_mapbox_tercer_intento/providers/pokemon_detail_provider.dart';
import 'package:flutter_mapbox_tercer_intento/providers/pokemon_provider.dart';
import 'package:flutter_mapbox_tercer_intento/screens/show_bottom_sheet.dart';
import 'package:flutter_mapbox_tercer_intento/service/pokemon_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    BuildContext context,
    List<PokemonModel> pokemons,
    WidgetRef ref,
  ) {
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
          child: GestureDetector(
            onTap: () async {
              final loading = ref.watch(pokemonNameProvider).isLoading;
              final id = ref.read(pokemonDetailProvider).pokemonDetailModel;
              final pokemonDetails = ref.read(pokemonDetailProvider);

              // Llama a fetchPokemonDetailService si el pokemonId está disponible
              ref
                  .read(pokemonDetailProvider.notifier)
                  .fetchPokemonDetailService(pokemon.id ?? 0);

              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 500,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(55.0),
                        topRight: Radius.circular(55.0),
                      ),
                    ),
                    child: (loading)
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              CircleAvatar(
                                minRadius: 90,
                                maxRadius: 110,
                                backgroundColor:
                                    const Color.fromARGB(66, 158, 158, 158),
                                child: Image.network(
                                  height: 300,
                                  width: 300,
                                  fit: BoxFit.cover,
                                  pokemon.image ??
                                      "https://media.istockphoto.com/id/1289461335/photo/portrait-of-a-handsome-black-man.jpg?s=612x612&w=0&k=20&c=gDibbpmkeV04ta3ociwAgpqcjdeU5sI1nnd78wrnz-g=",
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.network(
                                        "https://media.istockphoto.com/id/1289461335/photo/portrait-of-a-handsome-black-man.jpg?s=612x612&w=0&k=20&c=gDibbpmkeV04ta3ociwAgpqcjdeU5sI1nnd78wrnz-g=");
                                  },
                                ),
                              ),
                              Text(
                                pokemon.name ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              Text(
                                  "ID: ${pokemonDetails.pokemonDetailModel?.id}", style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20
                                  ),),
                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Base Experience",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    "${id?.baseExperience}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Height",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 135,
                                  ),
                                  Text(
                                    "${pokemonDetails.pokemonDetailModel?.height ?? "100"}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Weight",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 120,
                                  ),
                                  Text(
                                    "${pokemonDetails.pokemonDetailModel?.weight ?? 30}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              const Spacer()
                            ],
                          ),
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

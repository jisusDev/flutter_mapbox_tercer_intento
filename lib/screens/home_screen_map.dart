import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mapbox_tercer_intento/providers/map_screen_providers.dart';
import 'package:flutter_mapbox_tercer_intento/providers/pokemon_provider.dart';
import 'package:flutter_mapbox_tercer_intento/service/flutter_map_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

const myPosition = LatLng(4.700014, -74.042124);

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  late MapController mapController;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  final tileLayerOptions = MapService.getTileLayerOptions();

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = ref.watch(pokemonNameProvider);
    final themeDarkMode = ref.watch(isDarkModeProvider);

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: const MapOptions(
              initialCenter: myPosition,
              minZoom: 5,
              maxZoom: 19,
              initialZoom: 18,
            ),
            children: [
              if (themeDarkMode)
                MapService.getDarkTileLayerOptions()
              else 
                MapService.getTileLayerOptions(),
              MapService.getMarkerLayerOptions(
                context,
                pokemonProvider.pokemonModel?.results ?? [],
                ref,
              ),
              const MarkerLayer(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: myPosition,
                    child: Icon(
                      Icons.person,
                      color: Colors.blue,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: "Search location",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                        border: InputBorder.none,
                      ),
                      readOnly: true,
                    ),
                  ),
                  const Icon(Icons.mic, color: Colors.black),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 90,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 80, 80, 80),
              child: Icon(
                themeDarkMode
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                ref.read(isDarkModeProvider.notifier).state = !themeDarkMode;
              },
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 80, 80, 80),
              elevation: 30,
              child: const Icon(
                Icons.center_focus_strong,
                color: Colors.white,
              ),
              onPressed: () {
                mapController.move(myPosition, 18.0);
              },
            ),
          ),
        ],
      ),
    );
  }
}

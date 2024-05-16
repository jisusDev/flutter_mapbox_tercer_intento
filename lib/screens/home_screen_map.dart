import 'package:latlong2/latlong.dart';
import "package:flutter_mapbox_tercer_intento/widgets/widgets.dart";

const myPosition = LatLng(
  4.700014,
  -74.042124,
);

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
      body: _Body(
        mapController: mapController,
        themeDarkMode: themeDarkMode,
        pokemonProvider: pokemonProvider,
        ref: ref,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.mapController,
    required this.themeDarkMode,
    required this.pokemonProvider,
    required this.ref,
  });

  final MapController mapController;
  final bool themeDarkMode;
  final PokemonState pokemonProvider;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMapBody(mapController: mapController, themeDarkMode: themeDarkMode, pokemonProvider: pokemonProvider, ref: ref),
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
    );
  }
}



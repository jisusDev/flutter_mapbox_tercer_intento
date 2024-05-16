import "package:flutter_mapbox_tercer_intento/widgets/widgets.dart";

class FlutterMapBody extends StatelessWidget {
  const FlutterMapBody({
    super.key,
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
    return FlutterMap(
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
        GetMarkerLayerOptions(
          context: context,
          pokemons: pokemonProvider.pokemonModel?.results ?? [],
          ref: ref,
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
    );
  }
}

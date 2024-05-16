import "package:flutter_mapbox_tercer_intento/widgets/widgets.dart";
import "package:latlong2/latlong.dart";

LatLngBounds mapBounds = LatLngBounds(
  // const LatLng(4.6, -74.1),
  // const LatLng(4.8, -73.9),
  const LatLng(4.700014, -74.04212),
  const LatLng(4.703560, -74.038597),
);

class GetMarkerLayerOptions extends StatelessWidget {
  const GetMarkerLayerOptions({
    super.key,
    required this.context,
    required this.pokemons,
    required this.ref,
  });

  final BuildContext context;
  final List<PokemonModel> pokemons;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
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
                        : BottomSheetInfo(pokemonDetails: pokemonDetails, id: id, pokemon: pokemon,),
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



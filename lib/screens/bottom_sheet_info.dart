import "package:flutter_mapbox_tercer_intento/widgets/widgets.dart";

class BottomSheetInfo extends StatelessWidget {
  const BottomSheetInfo({
    super.key,
    required this.pokemon,
    required this.pokemonDetails,
    required this.id,
  });

  final PokemonModel pokemon;
  final PokemonDetailState pokemonDetails;
  final PokemonDetailModel? id;

  @override
  Widget build(BuildContext context) {
    return BottomSheetColumnRow(
        pokemon: pokemon, pokemonDetails: pokemonDetails, id: id);
  }
}

import "package:flutter_mapbox_tercer_intento/widgets/widgets.dart";

class BottomSheetInfo extends StatefulWidget {
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
  State<BottomSheetInfo> createState() => _BottomSheetInfoState();
}

class _BottomSheetInfoState extends State<BottomSheetInfo> {
  @override
  Widget build(BuildContext context) {
    return BottomSheetColumnRow(pokemon: widget.pokemon, id: widget.id);
  }
}

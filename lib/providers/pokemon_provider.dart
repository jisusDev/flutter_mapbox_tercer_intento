import "package:flutter_mapbox_tercer_intento/widgets/widgets.dart";


final pokemonNameProvider =
    StateNotifierProvider<PokemonNameNotifier, PokemonState>(
        (ref) => PokemonNameNotifier());

class PokemonNameNotifier extends StateNotifier<PokemonState> {
  final servicePokemon = Provider<PokemonService>((ref) {
    return PokemonService();
  });
  PokemonNameNotifier() : super(PokemonState()) {
    _fetchPokemonService();
  }
  Future<void> _fetchPokemonService() async {
    state = state.copyWith(isLoading: true);

    try {
      PokemonListResponse pokemonData = await PokemonService().getPokemonNames();

      state = state.copyWith(pokemonModel: pokemonData, isLoading: false);
    } catch (error) {
      state = state.copyWith(isLoading: false);
      ("Error fetching Pokemon data: $error");
    }
  }
}

class PokemonState {
  final PokemonListResponse? pokemonModel;
  final bool isLoading;

  PokemonState({this.isLoading = true, this.pokemonModel});

  PokemonState copyWith({
    bool? isLoading,
    PokemonListResponse? pokemonModel,
  }) =>
      PokemonState(
          isLoading: isLoading ?? this.isLoading,
          pokemonModel: pokemonModel ?? this.pokemonModel);
}
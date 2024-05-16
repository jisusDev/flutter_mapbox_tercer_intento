import 'package:flutter_mapbox_tercer_intento/model/pokemon_detail_model.dart';
import 'package:flutter_mapbox_tercer_intento/service/pokemon_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pokemonDetailProvider =
    StateNotifierProvider<PokemonDetailNotifier, PokemonDetailState>(
        (ref) => PokemonDetailNotifier());

class PokemonDetailNotifier extends StateNotifier<PokemonDetailState> {
  final servicePokemonDetail = Provider<PokemonDetailService>((ref,) {
    return PokemonDetailService();
  });
  PokemonDetailNotifier() : super(PokemonDetailState());

  Future<void> fetchPokemonDetailService(int pokemonId) async {
    state = state.copyWith(isLoading: true);

    try {
      PokemonDetailModel pokemonDetailData =
          await PokemonDetailService().getPokemonDetails(pokemonId);

      state = state.copyWith(
          pokemonDetailModel: pokemonDetailData, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      ("Error fetching Pokemons Details: $e");
    }
  }
}

class PokemonDetailState {
  final PokemonDetailModel? pokemonDetailModel;
  final bool isLoading;
  final bool showBottomSheet;

  PokemonDetailState({
    this.isLoading = false,
    this.pokemonDetailModel,
    this.showBottomSheet = false,
  });

  PokemonDetailState copyWith({
    bool? isLoading,
    PokemonDetailModel? pokemonDetailModel,
    bool? showBottomSheet,
  }) =>
      PokemonDetailState(
        isLoading: isLoading ?? this.isLoading,
        pokemonDetailModel: pokemonDetailModel ?? this.pokemonDetailModel,
        showBottomSheet: showBottomSheet ?? this.showBottomSheet,
      );
}

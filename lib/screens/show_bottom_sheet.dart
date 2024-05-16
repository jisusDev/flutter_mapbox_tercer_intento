import 'package:flutter/material.dart';
import 'package:flutter_mapbox_tercer_intento/providers/pokemon_detail_provider.dart';
import 'package:flutter_mapbox_tercer_intento/providers/pokemon_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomSheetPokemonView {
  // @override
  // Widget build(BuildContext context, WidgetRef ref) {
  //   return GestureDetector(
  //     onTap: () => _showModal(context, ref),
  //   );
  // }a

  static showModal(
    BuildContext context,
    WidgetRef ref,
  ) {
    final pokemon = ref.watch(pokemonNameProvider).pokemonModel;
    final loading = ref.watch(pokemonNameProvider).isLoading;
    final id = ref.read(pokemonDetailProvider).pokemonDetailModel;
    final pokemonDetails = ref.read(pokemonDetailProvider);
  
  final pokemonId = pokemon?.results?.first.id;

    // Llamar a _fetchPokemonService si el pokemonId está disponible
    if (pokemonId != null) {
      ref.read(pokemonNameProvider.notifier).servicePokemon;
    }

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
                    Image.network(
                      height: 180,
                      width: 180,
                      fit: BoxFit.cover,
                      pokemon?.results?.first.image ??
                          "https://media.istockphoto.com/id/1289461335/photo/portrait-of-a-handsome-black-man.jpg?s=612x612&w=0&k=20&c=gDibbpmkeV04ta3ociwAgpqcjdeU5sI1nnd78wrnz-g=",
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                            "https://media.istockphoto.com/id/1289461335/photo/portrait-of-a-handsome-black-man.jpg?s=612x612&w=0&k=20&c=gDibbpmkeV04ta3ociwAgpqcjdeU5sI1nnd78wrnz-g=");
                      },
                    ),
                    Text(
                      pokemon?.results?.first.name ?? "",
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Base Experience"),
                        const SizedBox(
                          width: 30,
                        ),
                        Text("${id?.baseExperience}")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Heigth"),
                        const SizedBox(
                          width: 100,
                        ),
                        Text(
                            "${pokemonDetails.pokemonDetailModel?.height ?? "100"}"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Weight",
                        ),
                        const SizedBox(
                          width: 92,
                        ),
                        Text(
                            "${pokemonDetails.pokemonDetailModel?.weight ?? 30}"),
                      ],
                    ),
                    const Spacer()
                  ],
                ),
        );
      },
    );
  }
}

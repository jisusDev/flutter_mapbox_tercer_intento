import 'package:flutter/material.dart';
import 'package:flutter_mapbox_tercer_intento/providers/pokemon_detail_provider.dart';
import 'package:flutter_mapbox_tercer_intento/providers/pokemon_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_mapbox_tercer_intento/model/model_pokemon.dart';
import 'package:flutter_mapbox_tercer_intento/model/pokemon_detail_model.dart';

class ShowModal extends ConsumerWidget {
  const ShowModal({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Aquí puedes leer tus providers
    // final myProvider = watch(myProvider);

    return GestureDetector(
      onTap: () => _showModal(context, ref),
      child: const Text('Mostrar Modal'),
    );
  }

  Future<dynamic> _showModal(BuildContext context, WidgetRef ref) {
    // Aquí puedes leer tus providers
    final pokemon = ref.watch(pokemonNameProvider);
    final id = ref.read(pokemonDetailProvider);
    final pokemonDetails = ref.read(pokemonDetailProvider);

    return showModalBottomSheet(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.network(
                  height: 180,
                  width: 180,
                  fit: BoxFit.cover,
                  pokemon.pokemonModel?.image ?? ""),
              Text(
                pokemon.pokemonModel?.name ?? "",
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
              Text(id.toString()),
              Text(id),
              const Spacer()
            ],
          ),
        );
      },
    );
  }
}

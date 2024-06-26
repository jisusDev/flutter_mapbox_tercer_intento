import "package:flutter_mapbox_tercer_intento/widgets/widgets.dart";

class BottomSheetColumnRow extends ConsumerWidget {
  const BottomSheetColumnRow({
    super.key,
    required this.pokemon,
    required this.id,
  });

  final PokemonModel pokemon;
  final PokemonDetailModel? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final pokemonDetails = ref.watch(pokemonDetailProvider).pokemonDetailModel;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30,
        ),
        CircleAvatar(
          minRadius: 90,
          maxRadius: 110,
          backgroundColor: const Color.fromARGB(66, 158, 158, 158),
          child: Image.network(
            height: 300,
            width: 300,
            fit: BoxFit.cover,
            pokemon.image ??
                "https://media.istockphoto.com/id/1289461335/photo/portrait-of-a-handsome-black-man.jpg?s=612x612&w=0&k=20&c=gDibbpmkeV04ta3ociwAgpqcjdeU5sI1nnd78wrnz-g=",
            errorBuilder: (context, error, stackTrace) {
              return Image.network(
                  "https://media.istockphoto.com/id/1289461335/photo/portrait-of-a-handsome-black-man.jpg?s=612x612&w=0&k=20&c=gDibbpmkeV04ta3ociwAgpqcjdeU5sI1nnd78wrnz-g=");
            },
          ),
        ),
        Text(
          pokemon.name ?? "",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        const SizedBox(
          width: 80,
        ),
        Text(
          "ID: ${pokemonDetails?.id}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Base Experience",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Text(
              "${pokemonDetails?.baseExperience}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Height",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              width: 135,
            ),
            Text(
              "${pokemonDetails?.height ?? "100"}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Weight",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              width: 120,
            ),
            Text(
              "${pokemonDetails?.weight ?? 30}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}

import 'dart:convert';

PokemonListResponse pokemonsFromJson(String str) =>
    PokemonListResponse.fromJson(json.decode(str));

String pokemonsToJson(PokemonListResponse data) => json.encode(data.toJson());

class PokemonListResponse {
  final int? count;
  final String? next;
  final dynamic previous;
  final List<PokemonModel>? results;

  PokemonListResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) =>
      PokemonListResponse(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        results: json['results'] == null
            ? []
            : List<PokemonModel>.from(
                json['results']?.map(
                  (pokemon) => PokemonModel.fromJson(pokemon),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'next': next,
        'previous': previous,
        'results': results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class PokemonModel {
  final String? name;
  final String? url;
  final String? image;
  double? lat; 
  double? lng; 

  PokemonModel({
    this.name,
    this.url,
    this.image,
    this.lat, 
    this.lng, 
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    final url = json['url'];
    List<String> splitUrl = url.split('/');
    String pokemonId = splitUrl[splitUrl.length - 2];

    return PokemonModel(
      name: json['name'],
      url: json['url'],
      image:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png',
      lat: null, 
      lng: null, 
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
        'lat': lat,
        'lng': lng,
      };
}


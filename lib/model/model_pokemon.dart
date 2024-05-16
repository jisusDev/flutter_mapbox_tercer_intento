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

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? resultsJson = json['results'];
    
    List<PokemonModel>? pokemonModels;
    if (resultsJson != null) {
      pokemonModels = resultsJson.map((pokemonJson) {
        final url = pokemonJson['url'];
        List<String> splitUrl = url.split('/');
        String pokemonId = splitUrl[splitUrl.length - 2];
        
        return PokemonModel.fromJson(pokemonJson, int.parse(pokemonId));
      }).toList();
    }

    return PokemonListResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: pokemonModels,
    );
  }

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
  int? id;

  PokemonModel({this.name, this.url, this.image, this.lat, this.lng, this.id});

  factory PokemonModel.fromJson(Map<String, dynamic> json, int id) {
    //final url = json['url'];

    return PokemonModel(
      name: json['name'],
      url: json['url'],
      image:
'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
      lat: null,
      lng: null,
      id: id,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
        'lat': lat,
        'lng': lng,
      };
}

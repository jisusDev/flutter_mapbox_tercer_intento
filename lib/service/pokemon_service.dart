
import 'package:dio/dio.dart';
import 'package:flutter_mapbox_tercer_intento/model/model_pokemon.dart';
import 'package:flutter_mapbox_tercer_intento/model/pokemon_detail_model.dart';

class PokemonService {
  var dio = Dio();
  final String baseUrl = "https://pokeapi.co/api/v2";
  final String endPoint = "pokemon/";

  Future<PokemonListResponse> getPokemonNames() async {
    String url = "$baseUrl/$endPoint";

    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        final pokemonListResponse = PokemonListResponse.fromJson(response.data);
        return pokemonListResponse;
      } else {
        throw Exception("Failed to load Pokemon Names: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load Everything: $e");
    }
  }
}

class PokemonDetailService {
  var dio = Dio();
  final String baseUrl = "https://pokeapi.co/api/v2/pokemon";
  

  Future<PokemonDetailModel> getPokemonDetails(int pokemonId) async {
    
    String url = "$baseUrl/$pokemonId";
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        final pokemonDetailResponse =
            PokemonDetailModel.fromJson(response.data);
        return pokemonDetailResponse;
      } else {
        throw Exception(
            "Failed to load pokemon Details: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load pokemon Details: $e");
    }
  }
}

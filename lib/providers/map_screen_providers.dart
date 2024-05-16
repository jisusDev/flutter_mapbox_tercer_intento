import "package:flutter_mapbox_tercer_intento/widgets/widgets.dart";

final isDarkModeProvider = StateProvider<bool>((ref) => false);

final mapScreenProvider =
    StateNotifierProvider<MapScreenNotifier, MapaState>((ref) {
  return MapScreenNotifier();
});

class MapScreenNotifier extends StateNotifier<MapaState> {
  final serviceMapScreenProvider = Provider<MapService>((ref) {
    return MapService();
  });

  MapScreenNotifier() : super(MapaState()) {
    _fetchMapService();
  }
  Future<void> _fetchMapService() async {
    state = state.copyWith(isLoading: true);

    try {
      MapService.getTileLayerOptions();
      state = state.copyWith(isLoading: false);
    } catch (error) {
      state = state.copyWith(isLoading: false);
      ("Error fetching Map data: $error");
    }
  }
}

class MapaState {
  final bool isLoading;

  MapaState({
    this.isLoading = false,
  });

  MapaState copyWith({
    bool? isLoading,
  }) =>
      MapaState(isLoading: isLoading ?? this.isLoading);
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domains/models/previews_model.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<FavoriteMoviesNotifier, List<Results>>((ref) {
  return FavoriteMoviesNotifier();
});

class FavoriteMoviesNotifier extends StateNotifier<List<Results>> {
  FavoriteMoviesNotifier() : super([]);

  void addFavorite(Results movie) {
    state = [...state, movie];
  }

  void removeFavorite(int id) {
    state = state.where((movie) => movie.id != id).toList();
  }

  void toggleFavorite(int id, String title, String posterPath,
      String originalLanguage, String overview, double voteaverage, String releaseDate) {
    final Results existingMovie = state.firstWhere(
      (movie) => movie.id == id,
      orElse: () => Results(
          id: -1,
          title: '',
          posterPath: '',
          originalLanguage: "",
          overview: "",
          voteaverage: 0),
    );
    if (existingMovie.id == -1) {
      addFavorite(Results(
          id: id,
          title: title,
          posterPath: posterPath,
          originalLanguage: originalLanguage,
          overview: overview,
          voteaverage: voteaverage, releaseDate:releaseDate ));
    } else {
      removeFavorite(id);
    }
  }

  void clearFavorites() {
    state = [];
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorites';

  Future<void> toggleFavorite(int movieId, String title, String posterPath) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteMovies = prefs.getStringList(_favoritesKey) ?? [];
    final movieData = '$movieId,$title,$posterPath';
    
    if (favoriteMovies.any((movie) => movie.startsWith(movieId.toString()))) {
      favoriteMovies.removeWhere((movie) => movie.startsWith(movieId.toString()));
    } else {
      favoriteMovies.add(movieData);
    }
    
    await prefs.setStringList(_favoritesKey, favoriteMovies);
  }

  Future<List<Map<String, String>>> getFavoriteMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteMovies = prefs.getStringList(_favoritesKey) ?? [];
    
    return favoriteMovies.map((movie) {
      final parts = movie.split(',');
      return {
        'id': parts[0],
        'title': parts[1],
        'posterPath': parts[2],
      };
    }).toList();
  }

  Future<bool> isFavorite(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteMovies = prefs.getStringList(_favoritesKey) ?? [];
    return favoriteMovies.any((movie) => movie.startsWith(movieId.toString()));
  }

  Future<void> removeFavorite(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteMovies = prefs.getStringList(_favoritesKey) ?? [];
    favoriteMovies.removeWhere((movie) => movie.startsWith(movieId.toString()));
    await prefs.setStringList(_favoritesKey, favoriteMovies);
  }

  Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_favoritesKey);
  }
}

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domains/models/previews_model.dart';

final watchedVideosProvider =
    StateNotifierProvider<WatchedVideosNotifier, List<Results>>((ref) {
  return WatchedVideosNotifier();
});

class WatchedVideosNotifier extends StateNotifier<List<Results>> {
  WatchedVideosNotifier() : super([]) {
    _loadWatchedVideos();
  }

  Future<void> _loadWatchedVideos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? watchedVideosJson = prefs.getStringList('watchedVideos');
    if (watchedVideosJson != null) {
      state = watchedVideosJson.map((jsonString) {
        return Results.fromJson(json.decode(jsonString));
      }).toList();
    }
  }

  Future<void> addWatchedVideo(Results video) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? watchedVideosJson = prefs.getStringList('watchedVideos');
    if (watchedVideosJson == null) {
      watchedVideosJson = [];
    }
    if (!watchedVideosJson.contains(json.encode(video.toJson()))) {
      watchedVideosJson.add(json.encode(video.toJson()));
      await prefs.setStringList('watchedVideos', watchedVideosJson);
      state = [...state, video];
    }
  }

   void removeFavorite(int id) {
    state = state.where((movie) => movie.id != id).toList();
  }
}

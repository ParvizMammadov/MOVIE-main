import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<String?> fetchVideoData(int movieId) async {
  const String apiKey =
      '2aff523ab63b65fe51dc5c7394eaf111'; // Replace with your actual API key
  final String apiUrl =
      'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey';

  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final Map<String, dynamic> data = jsonResponse;
      final List results = data["results"];
      if (results.isNotEmpty) {
        final Iterable keyMap = results.map((e) => e["key"]);
        final String key = keyMap.toList()[0];
        return key;
      } else {
        return "";
      }
    } else {
      debugPrint('Failed to fetch video data: ${response.statusCode}');
      return "";
    }
  } catch (e) {
    debugPrint('Error fetching video data: $e');
    return "";
  }
}

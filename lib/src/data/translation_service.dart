import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_dovie/src/domains/models/translation_model.dart'; // Ensure this path is correct

class TranslationService {
  final String apiKey = '2aff523ab63b65fe51dc5c7394eaf111';

  Future<Translation?> fetchTranslation(int movieId, String languageCode) async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/$movieId/translations?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final translations = data['translations'] as List;

      final translation = translations.firstWhere(
        (t) => t['iso_639_1'] == languageCode,
        orElse: () => null,
      );

      if (translation != null) {
        return Translation.fromJson(translation);
      }
    } else {
      throw Exception('Failed to load translations');
    }
    return null;
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_dovie/src/data/data_service.dart';

final apiProviderOfDay =
    FutureProvider((ref) => ApiService().fetchDataPopular(index: 1));
final apiProviderNowPlaying =
    FutureProvider((ref) => ApiService().fetchDataPopular(index: 2));
final apiProviderUpcoming =
    FutureProvider((ref) => ApiService().fetchDataPopular(index: 3));
final apiProviderTopRated =
    FutureProvider((ref) => ApiService().fetchDataPopular(index: 4));
final apiProviderPopular =
    FutureProvider((ref) => ApiService().fetchDataPopular(index: 5));

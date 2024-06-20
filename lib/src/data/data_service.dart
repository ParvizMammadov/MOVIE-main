// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../domains/models/previews_model.dart';

class ApiService {
  final Dio _dio = Dio();

  // ignore: body_might_complete_normally_nullable
  Future<PreviewsModel?> fetchDataPopular({required int index}) async {
    try {
      Response response = await _dio.get(
          "https://api.themoviedb.org/3/movie/popular?api_key=2aff523ab63b65fe51dc5c7394eaf111&page=$index");
      return PreviewsModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.message);
    }
  }

  // ignore: body_might_complete_normally_nullable
  Future<PreviewsModel?> searchMovies({required String query}) async {
    try {
      Response response = await _dio.get(
          "https://api.themoviedb.org/3/search/movie?api_key=2aff523ab63b65fe51dc5c7394eaf111&query=$query");
      return PreviewsModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.message);
    }
  }
}


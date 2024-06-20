class PreviewsModel {
  int? page;
  List<Results>? results;

  PreviewsModel({this.page, this.results});

  PreviewsModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  double? voteaverage;
  String? posterPath;
  String? releaseDate;
  String? title;

  Results(
      {this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.voteaverage,
      this.posterPath,
      this.releaseDate,
      this.title});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    originalLanguage = json['original_language'] ?? 'Unknown';
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    voteaverage = json['vote_average'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'] ?? 'Unknown';
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['vote_average'] = voteaverage;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = title;
    return data;
  }
}

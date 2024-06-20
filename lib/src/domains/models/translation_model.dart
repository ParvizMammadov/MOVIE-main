class Translation {
  final String languageCode;
  final String overview;
  final String title;

  Translation({
    required this.languageCode,
    required this.overview,
    required this.title,
  });

  factory Translation.fromJson(Map<String, dynamic> json) {
    return Translation(
      languageCode: json['iso_639_1'],
      overview: json['data']['overview'] ?? '',
      title: json['data']['title'] ?? '',
    );
  }
}

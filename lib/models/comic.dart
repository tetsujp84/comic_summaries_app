class Comic {
  final int id;
  final String title;
  final String synopsis;
  final String attraction;
  final String genre;
  final String characters;
  final String imagePath;
  final String spoilers;

  Comic({
    required this.id,
    required this.title,
    required this.synopsis,
    required this.attraction,
    required this.genre,
    required this.characters,
    required this.imagePath,
    required this.spoilers,
  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      id: json['id'],
      title: json['title'],
      synopsis: json['synopsis'],
      attraction: json['attraction'],
      genre: json['genre'],
      characters: json['characters'],
      imagePath: json['image_path'],
      spoilers: json['spoilers'],
    );
  }
}

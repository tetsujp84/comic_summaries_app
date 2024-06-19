import 'comic.dart';

class ComicResponse {
  final List<Comic> comics;

  ComicResponse({required this.comics});

  factory ComicResponse.fromJson(Map<String, dynamic> json) {
    var list = json['comics'] as List;
    List<Comic> comicsList = list.map((i) => Comic.fromJson(i)).toList();
    return ComicResponse(comics: comicsList);
  }
}

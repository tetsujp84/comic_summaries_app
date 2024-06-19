import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:comic_summaries_app/models/comic.dart';
import 'package:comic_summaries_app/models/comic_response.dart';
import 'package:comic_summaries_app/store/store.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> fetchComics(WidgetRef ref, int page) async {
  try {
    print('Fetching comics for page $page');
    final apiUrl = dotenv.env['API_URL']!;
    final response = await http.get(Uri.parse('$apiUrl/summaries?page=$page'));

    if (response.statusCode == 200) {
      final comicResponse = ComicResponse.fromJson(json.decode(response.body));
      ref.read(comicListProvider.notifier).setComics(comicResponse.comics);
    } else {
      print('Failed to load comics. Status code: ${response.statusCode}, Body: ${response.body}');
      ref.read(errorProvider.notifier).state = 'Failed to load comics';
    }
  } catch (e) {
    print('Error fetching comics: $e');
    ref.read(errorProvider.notifier).state = 'Error fetching comics';
  }
}

Future<void> fetchComicDetail(WidgetRef ref, String id) async {
  try {
    final apiUrl = dotenv.env['API_URL']!;
    final response = await http.get(Uri.parse('$apiUrl/summaries/$id'));
    if (response.statusCode == 200) {
      final comic = Comic.fromJson(json.decode(response.body));
      ref.read(comicDetailProvider.notifier).setComic(comic);
    } else {
      ref.read(errorProvider.notifier).state = 'Failed to load comic detail';
    }
  } catch (e) {
    ref.read(errorProvider.notifier).state = 'Error fetching comic detail';
  }
}

Future<int> fetchTotalComicsCount() async {
  try {
    final apiUrl = dotenv.env['API_URL']!;
    final response = await http.get(Uri.parse('$apiUrl/count'));
    if (response.statusCode == 200) {
      final count = json.decode(response.body)['count'];
      return count;
    } else {
      print('Failed to load total comics. Status code: ${response.statusCode}, Body: ${response.body}');
      return 0;
    }
  } catch (e) {
    print('Error fetching total comics: $e');
    return 0;
  }
}

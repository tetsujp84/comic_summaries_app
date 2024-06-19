import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:comic_summaries_app/models/comic.dart';

// コミックリストの状態を管理
class ComicListNotifier extends StateNotifier<List<Comic>> {
  ComicListNotifier() : super([]);

  void setComics(List<Comic> comics) {
    state = comics;
  }
}

final comicListProvider = StateNotifierProvider<ComicListNotifier, List<Comic>>((ref) {
  return ComicListNotifier();
});

// コミック詳細の状態を管理
class ComicDetailNotifier extends StateNotifier<Comic?> {
  ComicDetailNotifier() : super(null);

  void setComic(Comic comic) {
    state = comic;
  }
}

final comicDetailProvider = StateNotifierProvider<ComicDetailNotifier, Comic?>((ref) {
  return ComicDetailNotifier();
});

// コミックページの状態を管理
class ComicPageNotifier extends StateNotifier<int> {
  ComicPageNotifier() : super(1);

  void setPage(int page) {
    state = page;
  }
}

final comicPageProvider = StateNotifierProvider<ComicPageNotifier, int>((ref) {
  return ComicPageNotifier();
});

// エラーメッセージの状態を管理
final errorProvider = StateProvider<String?>((ref) => null);

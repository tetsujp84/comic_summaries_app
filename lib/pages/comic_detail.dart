import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:comic_summaries_app/services/comic_service.dart';
import 'package:comic_summaries_app/components/header.dart';
import 'package:comic_summaries_app/store/store.dart';

class ComicDetail extends ConsumerStatefulWidget {
  final String id;

  const ComicDetail({super.key, required this.id});

  @override
  _ComicDetailState createState() => _ComicDetailState();
}

class _ComicDetailState extends ConsumerState<ComicDetail> {
  bool showSpoilers = false;

  @override
  void initState() {
    super.initState();
    fetchComicDetail(ref, widget.id);
  }

  void toggleSpoilers() {
    setState(() {
      showSpoilers = !showSpoilers;
    });
  }

  @override
  Widget build(BuildContext context) {
    final comic = ref.watch(comicDetailProvider);

    if (comic == null) {
      return const Scaffold(
        appBar: Header(),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: const Header(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  comic.imagePath,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                comic.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'ジャンル: ${comic.genre}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              const Text(
                'キャラクター紹介',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(comic.characters),
              const SizedBox(height: 16),
              const Text(
                'あらすじ',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(comic.synopsis),
              const SizedBox(height: 16),
              const Text(
                'ネタバレ',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: toggleSpoilers,
                child: Text(showSpoilers ? 'ネタバレを隠す' : 'ネタバレを表示'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
              const SizedBox(height: 8),
              if (showSpoilers) Text(comic.spoilers),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:comic_summaries_app/services/comic_service.dart';
import 'package:comic_summaries_app/store/store.dart';
import 'package:comic_summaries_app/components/header.dart';
import 'package:go_router/go_router.dart';

class ComicList extends ConsumerStatefulWidget {
  const ComicList({super.key});

  @override
  ComicListState createState() => ComicListState();
}

class ComicListState extends ConsumerState<ComicList> {
  int totalComics = 0;
  int totalPages = 0;
  final int itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    fetchTotalComics();
    fetchComics(ref, ref.read(comicPageProvider));
  }

  Future<void> fetchTotalComics() async {
    totalComics = await fetchTotalComicsCount();
    totalPages = (totalComics / itemsPerPage).ceil();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final comics = ref.watch(comicListProvider);
    final currentPage = ref.watch(comicPageProvider);
    final error = ref.watch(errorProvider.notifier).state;

    return Scaffold(
        appBar: const Header(),
        body: SafeArea(
            child: Column(
          children: [
            if (comics.isEmpty && error == null)
              const Center(child: CircularProgressIndicator())
            else if (error != null)
              Center(child: Text(error))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: comics.length,
                  itemBuilder: (context, index) {
                    final comic = comics[index];
                    return ListTile(
                      leading: Image.network(
                        comic.imagePath,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(comic.title),
                      onTap: () {
                        GoRouter.of(context).push('/comic/${comic.id}');
                      },
                    );
                  },
                ),
              ),
            Pagination(
              currentPage: currentPage,
              totalPages: totalPages,
              onPageChange: (page) {
                ref.read(comicPageProvider.notifier).setPage(page);
                fetchComics(ref, page);
              },
            ),
          ],
        )));
  }
}

class Pagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChange;

  const Pagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:
              currentPage > 1 ? () => onPageChange(currentPage - 1) : null,
        ),
        for (int i = 1; i <= totalPages; i++)
          GestureDetector(
            onTap: () => onPageChange(i),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                color: i == currentPage ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                '$i',
                style: TextStyle(
                  color: i == currentPage ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: currentPage < totalPages
              ? () => onPageChange(currentPage + 1)
              : null,
        ),
      ],
    );
  }
}

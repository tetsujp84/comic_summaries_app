import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:comic_summaries_app/pages/comic_list.dart';
import 'package:comic_summaries_app/pages/comic_detail.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const ComicList(),
        ),
        GoRoute(
          path: '/comic/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return ComicDetail(id: id);
          },
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Comic Summaries',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}

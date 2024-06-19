import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return MaterialApp(
      title: 'Comic Summaries',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/comic') {
          final id = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return ComicDetail(id: id);
            },
          );
        }
        return null;
      },
      routes: {
        '/': (context) => const ComicList(),
      },
    );
  }
}

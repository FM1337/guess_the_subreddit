import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_subreddit/providers/settings_provider.dart';
import 'package:guess_the_subreddit/widgets/game.dart';
import 'package:guess_the_subreddit/widgets/welcome.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!Platform.isAndroid && !Platform.isIOS) {
    await windowManager.ensureInitialized();
    // Set the title of the window
    windowManager.setTitle('Guess The Subreddit');
    // set the minimum size of the window
    windowManager.setMinimumSize(const Size(500, 800));
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess The Subreddit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Guess The Subreddit'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  bool atMain = true;

  @override
  Widget build(BuildContext context) {
    ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
          child: atMain
              ? Welcome(callback: () => setState(() => atMain = false))
              : Game(
                  callback: () => setState(() {
                    atMain = true;
                  }),
                )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_subreddit/widgets/settings.dart';

class Welcome extends ConsumerWidget {
  final Function callback;
  const Welcome({super.key, required this.callback});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        const Center(
          child: Text("Welcome to Guess The Subreddit!",
              style: TextStyle(fontSize: 24)),
        ),
        const SizedBox(height: 20),
        const Center(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
                "You'll be presented with a random post title, and will have 4 subreddit options to choose from. Can you guess the correct subreddit? Let's find out!",
                style: TextStyle(fontSize: 18)),
          ),
        ),
        const Divider(),
        SettingsWidget(),
        const Divider(),
        Center(
          child: ElevatedButton(
            onPressed: () => callback(),
            child: const Text(
              'Start',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
      ]),
    );

    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     const Align(
    //       alignment: Alignment.topCenter,
    //       child: Padding(
    //         padding: EdgeInsets.all(16.0),
    //         child: Text(
    //           'Welcome to Guess The Subreddit!',
    //           style: TextStyle(fontSize: 24),
    //         ),
    //       ),
    //     ),
    //     const Align(
    //       alignment: Alignment.topCenter,
    //       child: Padding(
    //         padding: EdgeInsets.all(16.0),
    //         child: Text(
    //           "You'll be presented with a random post title, and will have 4 subreddit options to choose from. Can you guess the correct subreddit? Let's find out!",
    //           style: TextStyle(fontSize: 23),
    //         ),
    //       ),
    //     ),
    //     const Spacer(),
    //     Center(
    //       child: ElevatedButton(
    //         onPressed: () => callback(),
    //         child: const Text(
    //           'Start',
    //           style: TextStyle(fontSize: 25),
    //         ),
    //       ),
    //     ),
    //     const Spacer(),
    //   ],
    // );
  }
}

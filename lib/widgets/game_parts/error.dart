import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_subreddit/enums/state.dart';
import 'package:guess_the_subreddit/providers/game_provider.dart';
import 'package:guess_the_subreddit/providers/round_provider.dart';

class ErrorCatch extends ConsumerWidget {
  const ErrorCatch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(roundProvider);
    return Center(
        child: Column(
      children: [
        const SizedBox(height: 50),
        const Icon(Icons.error, size: 100, color: Colors.red),
        const Text(
          "An error occurred!",
          style: TextStyle(fontSize: 30),
        ),
        const SizedBox(height: 50),
        const Text("Click the button below to try again... "),
        const Text(
            "If the error persists, wait a few moments before trying again."),
        const SizedBox(height: 50),
        ElevatedButton(
          onPressed: () {
            ref.read(gameProvider.notifier).setGameState(GameState.loading);
          },
          child: const Text("Try Again"),
        ),
      ],
    ));
  }
}

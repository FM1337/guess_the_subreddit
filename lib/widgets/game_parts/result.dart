import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_subreddit/enums/state.dart';
import 'package:guess_the_subreddit/providers/game_provider.dart';
import 'package:guess_the_subreddit/providers/round_provider.dart';

class Result extends ConsumerWidget {
  const Result({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final round = ref.watch(roundProvider);

    final correct = round.correctSubreddit == round.selectedAnswer;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (ref.read(gameProvider).round == ref.read(gameProvider).rounds) {
        // wait 3 seconds before showing the game over screen
        Future.delayed(const Duration(seconds: 3), () {
          ref.read(gameProvider.notifier).setGameState(GameState.gameOver);
        });

        return;
      }

      ref.read(roundProvider.notifier).initRound(nextRound: true);
    });

    return Center(
      child: Column(
        children: [
          const SizedBox(height: 50),
          Icon(correct ? Icons.check : Icons.close,
              size: 100, color: correct ? Colors.green : Colors.red),
          Text(
            correct ? "Correct!" : "Incorrect!",
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 50),
          Text(
            "The correct answer was: ${ref.read(roundProvider).correctSubreddit}",
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 50),
          ref.read(gameProvider).round == ref.read(gameProvider).rounds
              ? const Text("Your score will be displayed shortly...")
              : const Text("Next round will begin shortly..."),
        ],
      ),
    );
  }
}

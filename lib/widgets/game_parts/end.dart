import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_subreddit/providers/game_provider.dart';

class GameOver extends ConsumerWidget {
  const GameOver({
    super.key,
    required this.callback,
  });

  // final int score;
  final Function callback;

  String getRank(int score, int total) {
    // calculate the percentage
    score = (score / total * 100).round();

    if (score == 0) {
      return "You didn't event get one...";
    } else if (score < 25) {
      return "You can do better!";
    } else if (score < 50) {
      return "Not bad.";
    } else if (score == 50) {
      return "You got half of them, good job!";
    } else if (score < 75) {
      return "You did pretty good!";
    } else if (score < 100) {
      return "Great job!";
    } else {
      return "You got them all, excellent job!";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 50),
          const Text(
            "Game Over!",
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 50),
          Text(
            "Your score: ${ref.read(gameProvider).score}/${ref.read(gameProvider).rounds} (${(ref.read(gameProvider).score / ref.read(gameProvider).rounds * 100).round()}%)",
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            getRank(
                ref.read(gameProvider).score, ref.read(gameProvider).rounds),
            style: const TextStyle(fontSize: 17),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  ref.read(gameProvider.notifier).resetGame();
                },
                child: const Text("Play Again"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  callback();
                },
                child: const Text("Exit"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

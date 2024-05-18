import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_subreddit/enums/state.dart';
import 'package:guess_the_subreddit/providers/game_provider.dart';
import 'package:guess_the_subreddit/providers/round_provider.dart';
import 'package:guess_the_subreddit/widgets/game_parts/end.dart';
import 'package:guess_the_subreddit/widgets/game_parts/loading.dart';
import 'package:guess_the_subreddit/widgets/game_parts/question.dart';
import 'package:guess_the_subreddit/widgets/game_parts/result.dart';
import 'package:guess_the_subreddit/widgets/game_parts/error.dart';

class Game extends ConsumerWidget {
  const Game({super.key, required this.callback});

  final Function callback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);

    switch (game.state) {
      case GameState.start:
        ref.read(gameProvider.notifier).startGame();
        return const Loading();
      case GameState.loading:
        ref.read(roundProvider.notifier).initRound();
        return const Loading();
      case GameState.question:
        return const Question();
      case GameState.showResult:
        return const Result();
      case GameState.gameOver:
        return GameOver(
          callback: callback,
        );
      case GameState.errorOccurred:
        return const ErrorCatch();
      default:
        return const Text("I messed up somehow.");
    }
  }
}

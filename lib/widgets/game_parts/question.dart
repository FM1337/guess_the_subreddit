import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_subreddit/providers/game_provider.dart';
import 'package:guess_the_subreddit/providers/round_provider.dart';
import 'package:guess_the_subreddit/widgets/game_parts/timer.dart';
import 'package:guess_the_subreddit/widgets/help.dart';

class Question extends ConsumerWidget {
  const Question({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final round = ref.watch(roundProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
              child: Text(
                  "Round ${ref.read(gameProvider).round}/${ref.read(gameProvider).rounds}",
                  style: const TextStyle(fontSize: 20))),
          const SizedBox(height: 10),
          ref.read(gameProvider).timerEnabled
              ? const RoundTimer()
              : const SizedBox(),
          const Center(
              child: Text("What Subreddit is this post from?",
                  style: TextStyle(fontSize: 25))),
          const SizedBox(height: 20),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                round.postTitle,
                overflow: TextOverflow.clip,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 100),
          SizedBox(
            width: 500,
            child: GridView.count(
                primary: false,
                crossAxisCount: 2,
                childAspectRatio: 3,
                shrinkWrap: true,
                children: round.options
                    .map((option) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(roundProvider.notifier)
                                  .setSelectedAnswer(option);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: option == round.selectedAnswer
                                  ? Colors.teal
                                  : Colors.cyan,
                            ),
                            child: Text(
                              option,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ))
                    .toList()),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
              onPressed: round.selectedAnswer.isEmpty
                  ? null
                  : () => ref.read(roundProvider.notifier).submitAnswer(),
              child: const Text(
                "Submit Answer",
                style: TextStyle(color: Colors.black, fontSize: 15),
              )),
          const SizedBox(height: 20),
          round.usedLifeLine || ref.read(gameProvider).lifelines == 0
              ? const SizedBox()
              : const HelpLifeLine(),
        ],
      ),
    );
  }
}

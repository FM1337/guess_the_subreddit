import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_subreddit/providers/game_provider.dart';
import 'package:guess_the_subreddit/providers/round_provider.dart';

class RoundTimer extends ConsumerStatefulWidget {
  const RoundTimer({super.key});

  @override
  ConsumerState<RoundTimer> createState() => _RoundTimerState();
}

class _RoundTimerState extends ConsumerState<RoundTimer> {
  late int timeLeft;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timeLeft = ref.read(gameProvider).timePerRound;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft == 0) {
        ref.read(roundProvider.notifier).submitAnswer();
        timer.cancel();
      } else {
        setState(() {
          timeLeft--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Time left: $timeLeft",
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}

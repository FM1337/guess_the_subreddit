import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_subreddit/providers/game_provider.dart';
import 'package:guess_the_subreddit/providers/round_provider.dart';

class HelpLifeLine extends ConsumerWidget {
  const HelpLifeLine({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        ref.read(roundProvider.notifier).useLifeLine();
      },
      child: const Text("Use Life Line"),
    );
  }
}

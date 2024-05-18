import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_subreddit/providers/round_provider.dart';

class Loading extends ConsumerWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(roundProvider);
    return const Center(
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
          Flexible(
            child: Text(
              "Loading Reddit Data, Please Wait",
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}

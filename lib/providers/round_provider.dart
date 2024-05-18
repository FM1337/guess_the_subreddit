import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_subreddit/enums/state.dart';
import 'package:guess_the_subreddit/models/round.dart';
import 'package:guess_the_subreddit/providers/game_provider.dart';
import 'package:guess_the_subreddit/utils/fetch.dart';

class RoundProvider extends StateNotifier<Round> {
  RoundProvider(this.ref, super.state);

  final Ref ref;

  final RedditRequester requester = RedditRequester();

  void setState({
    int? round,
    String? postTitle,
    String? correctSubreddit,
    List<String>? options,
    String? selectedAnswer,
    bool? usedLifeLine,
  }) {
    state = Round(
      postTitle: postTitle ?? state.postTitle,
      correctSubreddit: correctSubreddit ?? state.correctSubreddit,
      options: options ?? state.options,
      selectedAnswer: selectedAnswer ?? state.selectedAnswer,
      usedLifeLine: usedLifeLine ?? state.usedLifeLine,
    );
  }

  void setPostTitle(String title) {
    setState(postTitle: title);
  }

  void setCorrectSubreddit(String subreddit) {
    setState(correctSubreddit: subreddit);
  }

  void setOptions(List<String> options) {
    setState(options: options);
  }

  void setSelectedAnswer(String answer) {
    setState(selectedAnswer: answer);
  }

  void useLifeLine() {
    ref.read(gameProvider.notifier).decrementLifeLines();
    // remove two options that are invalid
    final rand = Random();
    final invalidOptions = state.options
        .where((element) => element != state.correctSubreddit)
        .toList();

    // choose 2 random options to remove
    final option1 = invalidOptions[rand.nextInt(3)];
    invalidOptions.remove(option1);
    final option2 = invalidOptions[rand.nextInt(2)];
    invalidOptions.remove(option2);

    setState(usedLifeLine: true, selectedAnswer: '', options: [
      state.correctSubreddit,
      invalidOptions[0],
    ]);
  }

  Future<void> initRound({bool nextRound = false}) async {
    List<String> randOptions = [];
    String post = "";
    String subreddit = "";

    try {
      randOptions = await requester.getRandomSubReddits();
      final rand = Random();
      subreddit = randOptions[rand.nextInt(4)];

      post = await requester.getRandomPost(subreddit);
    } catch (e, stacktrace) {
      print("Error occurred: $e $stacktrace");
    } finally {
      if (randOptions.isNotEmpty && post.isNotEmpty && subreddit.isNotEmpty) {
        // set the state for the next round
        setState(
          postTitle: post,
          correctSubreddit: subreddit,
          options: randOptions,
          selectedAnswer: '',
          usedLifeLine: false,
        );

        if (nextRound) {
          ref.read(gameProvider.notifier).incrementRound();
        }

        ref.read(gameProvider.notifier).setGameState(GameState.question);
      } else {
        // set the state for the error
        setState(
          postTitle: state.postTitle,
          correctSubreddit: state.correctSubreddit,
          options: state.options,
          usedLifeLine: false,
        );

        if (nextRound) {
          ref.read(gameProvider.notifier).incrementRound();
        }

        ref.read(gameProvider.notifier).setGameState(GameState.errorOccurred);
      }
    }
  }

  void submitAnswer() {
    ref.read(gameProvider.notifier).setGameState(GameState.showResult);

    if (state.selectedAnswer == state.correctSubreddit) {
      ref.read(gameProvider.notifier).incrementScore();
    }
  }
}

final roundProvider =
    StateNotifierProvider.autoDispose<RoundProvider, Round>((ref) {
  return RoundProvider(
      ref,
      Round(
        postTitle: '',
        correctSubreddit: '',
        options: [],
        selectedAnswer: '',
        usedLifeLine: false,
      ));
});

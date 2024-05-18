import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_subreddit/enums/state.dart';
import 'package:guess_the_subreddit/models/game.dart';
import 'package:guess_the_subreddit/providers/settings_provider.dart';

class GameProvider extends StateNotifier<Game> {
  GameProvider(this.ref, Game state) : super(state);

  final Ref ref;

  void setState({
    int? score,
    int? round,
    int? rounds,
    int? timePerRound,
    int? lifelines,
    bool? timerEnabled,
    GameState? gameState,
  }) {
    state = Game(
      score: score ?? state.score,
      round: round ?? state.round,
      rounds: rounds ?? state.rounds,
      lifelines: lifelines ?? state.lifelines,
      timePerRound: timePerRound ?? state.timePerRound,
      timerEnabled: timerEnabled ?? state.timerEnabled,
      state: gameState ?? state.state,
    );
  }

  void incrementScore() {
    setState(score: state.score + 1);
  }

  void incrementRound() {
    setState(round: state.round + 1);
  }

  void toggleTimer() {
    setState(timerEnabled: !state.timerEnabled);
  }

  void setTimePerRound(int time) {
    setState(timePerRound: time);
  }

  void resetGame() {
    setState(score: 0, round: 1, gameState: GameState.loading);
  }

  void setGameState(GameState gameState) {
    setState(gameState: gameState);
  }

  void decrementLifeLines() {
    setState(lifelines: state.lifelines - 1);
  }

  void startGame() async {
    // wait for the settings to be loaded
    await Future.delayed(const Duration(milliseconds: 500));
    final settings = ref.read(settingsProvider);
    setState(
      timerEnabled: settings.timerEnabled,
      rounds: settings.rounds,
      timePerRound: settings.timePerRound,
      lifelines: settings.lifeLines,
      gameState: GameState.loading,
    );
  }
}

final gameProvider =
    StateNotifierProvider.autoDispose<GameProvider, Game>((ref) {
  return GameProvider(
      ref,
      Game(
        score: 0,
        round: 1,
        rounds: 10,
        timePerRound: 120,
        timerEnabled: false,
        state: GameState.start,
        lifelines: 2,
      ));
});

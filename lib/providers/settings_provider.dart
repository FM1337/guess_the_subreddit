import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_subreddit/models/settings.dart';

class SettingsProvider extends StateNotifier<Settings> {
  SettingsProvider(this.ref, super.state);

  final Ref ref;

  void setState({
    int? rounds,
    int? timePerRound,
    int? lifeLines,
    bool? timerEnabled,
  }) {
    state = Settings(
      rounds: rounds ?? state.rounds,
      timePerRound: timePerRound ?? state.timePerRound,
      lifeLines: lifeLines ?? state.lifeLines,
      timerEnabled: timerEnabled ?? state.timerEnabled,
    );
  }

  void setRounds(int rounds) {
    setState(rounds: rounds);
  }

  void setTimePerRound(int time) {
    setState(timePerRound: time);
  }

  void toggleTimer() {
    setState(timerEnabled: !state.timerEnabled);
  }

  void setLifeLines(int lifeLines) {
    setState(lifeLines: lifeLines);
  }
}

final settingsProvider =
    StateNotifierProvider.autoDispose<SettingsProvider, Settings>((ref) {
  return SettingsProvider(
      ref,
      Settings(
          rounds: 10, timePerRound: 60, lifeLines: 2, timerEnabled: false));
});

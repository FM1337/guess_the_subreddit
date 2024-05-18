import 'package:guess_the_subreddit/enums/state.dart';

class Game {
  final int score;
  final int round;
  final int rounds;
  final int lifelines;
  final int timePerRound;
  final bool timerEnabled;
  final GameState state;

  Game({
    required this.score,
    required this.round,
    required this.rounds,
    required this.timePerRound,
    required this.timerEnabled,
    required this.state,
    required this.lifelines,
  });
}

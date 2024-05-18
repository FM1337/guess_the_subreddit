class Round {
  final String postTitle;
  final String correctSubreddit;
  final List<String> options;
  final String selectedAnswer;
  final bool usedLifeLine;

  Round({
    required this.postTitle,
    required this.correctSubreddit,
    required this.options,
    required this.selectedAnswer,
    required this.usedLifeLine,
  });
}

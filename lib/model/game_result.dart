class GameResult implements Comparable<GameResult> {
  final String player;
  final int score;

  GameResult({required this.player, required this.score});

  @override
  int compareTo(GameResult other) {
    return other.score.compareTo(score);
  }
}

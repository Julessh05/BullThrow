enum Ring { normal, double, triple, innerBull, outerBull }

/// Represents a single thow of a player in a game
final class DartThrow {
  final int sector;
  final Ring ring;
  final int score;

  DartThrow(this.sector, this.ring, this.score);
}

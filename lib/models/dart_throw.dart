

enum Ring { single, double, triple, innerBull, outerBull, out }

/// Represents a single throw of a player in a game
final class DartThrow {
  late final int sector;
  late final Ring ring;
  late final int score;

  DartThrow(this.sector, this.ring, this.score);

  DartThrow.single(this.sector) {
    ring = Ring.single;
    score = 1 * sector;
  }

  DartThrow.double(this.sector) {
    ring = Ring.double;
    score = 2 * sector;
  }

  DartThrow.triple(this.sector) {
    ring = Ring.triple;
    score = 3 * sector;
  }

  DartThrow.innerBull() {
    ring = Ring.innerBull;
    sector = 25;
    score = 2 * sector;
  }

  DartThrow.outerBull() {
    ring = Ring.outerBull;
    sector = 25;
    score = 1 * sector;
  }

  DartThrow.out() {
    ring = Ring.out;
    sector = 0;
    score = sector;
  }
}

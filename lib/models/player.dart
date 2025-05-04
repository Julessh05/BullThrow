import 'package:bull_throw/models/dart_throw.dart';

/// A single darts player in this app
final class Player {
  /// the Name of the darts player
  final String name;

  /// Internal points of this player
  int _points = 0;

  /// All the throws the player made in a single game
  final List<DartThrow> throws = [];

  Player(this.name, {int points = 0}) {
    _points = points;
  }

  /// External getter for the player points.
  /// To modify the points, use the provided methods [updatePoints] to update in-game
  /// or [setInitialPoints] to set the points to the beginning of the game
  int get points => _points;

  /// Sets the initial points for this player
  void setInitialPoints(final int points) {
    _points = points;
  }

  /// updates the points for the player based on what they threw
  void updatePoints(final int pointsThrown) {
    // TODO: check if points are possible and then update points
    _points -= pointsThrown;
  }
}

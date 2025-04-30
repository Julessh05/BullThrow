class Player {
  Player(this.name, {int points = 0}) {
    _points = points;
  }

  String name;

  int _points = 0;

  int get points => _points;

  void setInitialPoints(int points) {
    _points = points;
  }

  void updatePoints(int pointsThrown) {
    // TODO: check if points are possible and then update points
    _points -= pointsThrown;
  }
}
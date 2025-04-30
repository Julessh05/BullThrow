import 'dart:collection';

import 'package:bloc_implementation/bloc_implementation.dart';
import 'package:bull_throw/models/player.dart';

/// The bloc for the X01 game modes config screen
final class X01ConfigBloc extends Bloc {
  /* Local variables */
  int _points = 501;

  final List<Player> _players = [];

  /* Getters */
  int get points => _points;

  UnmodifiableListView<Player> get players => UnmodifiableListView(_players);

  /* Methods */
  void updatePoints(points) {
    _points = points;
    for (Player player in _players) {
      player.setInitialPoints(_points);
    }
  }

  void addNewPlayer(Player newPlayer) {
    newPlayer.setInitialPoints(_points);
    _players.add(newPlayer);
  }

  @override
  void dispose() {
    _points = 0;
    _players.removeRange(0, _players.length);
  }
}
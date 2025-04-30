import 'dart:collection';

import 'package:bloc_implementation/bloc_implementation.dart';
import 'package:bull_throw/errors/duplicate_name_error.dart';
import 'package:bull_throw/models/player.dart';

import '../errors/empty_player_name.dart';

/// The bloc for the X01 game modes config screen
final class X01ConfigBloc extends Bloc {
  /* Local variables */
  int _points = 501;

  final List<Player> _players = [];

  /* Getters */
  int get points => _points;

  UnmodifiableListView<Player> get players => UnmodifiableListView(_players);

  /* Methods */
  void updatePoints(final int points) {
    _points = points;
    for (Player player in _players) {
      player.setInitialPoints(_points);
    }
  }

  void addNewPlayer(final String newPlayerName) {
    if (newPlayerName.isEmpty) {
      throw EmptyPlayerNameError();
    } else if (_players.where((p) => p.name == newPlayerName).isNotEmpty) {
      throw DuplicateNameError();
    }
    Player newPlayer = Player(newPlayerName);
    newPlayer.setInitialPoints(_points);
    _players.add(newPlayer);
  }

  void removePlayer(final Player player) {
    _players.removeWhere((Player p) => p == player);
  }

  @override
  void dispose() {
    _points = 0;
    _players.removeRange(0, _players.length);
  }
}
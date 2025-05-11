import 'dart:collection' show UnmodifiableListView;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:bull_throw/errors/duplicate_name_error.dart';
import 'package:bull_throw/errors/empty_player_name.dart';
import 'package:bull_throw/models/player.dart';

/// The bloc for the X01 game modes config screen
final class X01ConfigBloc extends Bloc {
  /* Local variables */
  int _points = 501;

  final List<Player> _players = [];

  /* Getters */
  int get points => _points;

  /// Getter for the players. This list cannot be modified. To modify the list of players,
  /// use the provided methods
  UnmodifiableListView<Player> get players => UnmodifiableListView(_players);

  /* Methods */

  /// Updates the points for all players in the list
  void updatePoints(final int points) {
    _points = points;
    for (Player player in _players) {
      player.setInitialPoints(_points);
    }
  }

  /// Adds a new player, created from the name passed to the list of players
  /// and sets the points right
  void addNewPlayer(final String newPlayerName) {
    if (newPlayerName.isEmpty) {
      throw EmptyPlayerNameError();
    } else if (_players.where((p) => p.name == newPlayerName).isNotEmpty) {
      throw DuplicateNameError();
    }
    final Player newPlayer = Player(newPlayerName);
    newPlayer.setInitialPoints(_points);
    _players.add(newPlayer);
  }

  /// Removes a player from the list
  void removePlayer(final Player player) {
    _players.removeWhere((Player p) => p == player);
  }

  @override
  void dispose() {
    _points = 0;
    _players.removeRange(0, _players.length);
  }
}

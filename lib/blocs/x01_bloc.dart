import 'dart:collection';

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:bull_throw/models/player.dart';

final class X01Bloc extends Bloc {
  final UnmodifiableListView<Player> _players;

  UnmodifiableListView<Player> get players => _players;

  X01Bloc(this._players);

  int? getPointsForPosition(final Player player, final int position) {
    if (player.throws.length - position < 0) {
      return null;
    } else {
      return player.throws[player.throws.length - position].points *
          player.throws[player.throws.length - position].multiplicator;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}

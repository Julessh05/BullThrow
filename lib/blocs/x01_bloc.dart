import 'dart:collection' show UnmodifiableListView;
import 'dart:math' show atan2, pi, pow, sqrt;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:bull_throw/models/dart_throw.dart';
import 'package:bull_throw/models/player.dart';
import 'package:bull_throw/views/components/dartboard_painter.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Offset,
        RenderBox,
        Size,
        TapDownDetails,
        TransformationController;
import 'package:vector_math/vector_math_64.dart' show Matrix4, Vector3;

final class X01Bloc extends Bloc {
  /// the private variable for all the players in this game
  final UnmodifiableListView<Player> _players;

  /// All the players in the current game
  UnmodifiableListView<Player> get players => _players;

  /// The current player of this game
  Player? _currentPlayer;

  X01Bloc(this._players);

  /// Returns the current points for the according
  /// position which is the "throw index" of the
  /// current throw in the current round for the current user
  int? getPointsForPosition(final Player player, final int position) {
    if (player.throws.length - position < 0) {
      return null;
    }
    return player.throws[player.throws.length - position].score;
  }

  /// Called when its the next players turn
  void nextPlayer() {
    final int currentIndex = players.indexOf(_currentPlayer);
    _currentPlayer =
        currentIndex == players.length ? players[0] : players[currentIndex + 1];
  }

  /// Processes a throw for a specific user
  void processThrow(
    TapDownDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    // Calculate position
    final Offset localPosition = details.localPosition;
    // TODO: lookup matrix4 copy. Is there another way?
    final Matrix4 inverse = Matrix4.copy(controller.value)..invert();
    final Vector3 transformed = inverse.transform3(
      Vector3(localPosition.dx, localPosition.dy, 0),
    );
    final Offset boardPosition = Offset(transformed.x, transformed.y);

    // get dartboard size
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Size size = box.size;
    final Offset center = Offset(size.width / 2, size.width / 2);

    // calculate relative position
    final Offset relative = boardPosition - center;

    // Calculate radius of hit
    final double radius = sqrt(pow(relative.dx, 2) + pow(relative.dy, 2));
    final double completeRadius = size.width / 2;
    final DartThrow t;
    if (radius > completeRadius) {
      // Hit is out of board
      t = DartThrow.out();
    } else if (radius <= completeRadius * .037) {
      // Hit is inner bull
      t = DartThrow.innerBull();
    } else if (radius <= completeRadius * .094) {
      // Hit is outer bull
      t = DartThrow.outerBull();
    } else {
      // Calculate angle of hit to get sector
      final double angle =
          atan2(relative.dy, relative.dx) - (-pi / 2 - pi / 20);
      // pi / 10 is same as 2* pi / sectorCount of Dartboard which is 20. This calculates the anglePerSector of the Dartboard
      // ~/ is integer division
      final int sectorIndex = angle ~/ (pi / 10);
      final int sector = DartboardPainter.dartboardNumbers[sectorIndex];
      if (radius >= completeRadius * .582 && radius <= completeRadius * .629) {
        // hit is in triples
        t = DartThrow.triple(sector);
      } else if (radius >= completeRadius * .953 &&
          radius <= completeRadius * 1) {
        t = DartThrow.double(sector);
      } else {
        t = DartThrow.single(sector);
      }
    }
    // Add throw to list
    _addThrow(t);
  }

  /// Adds a new throw to list of throws for a player
  void _addThrow(DartThrow t) => _currentPlayer!.throws.add(t);

  @override
  void dispose() {
    _currentPlayer = null;
  }
}

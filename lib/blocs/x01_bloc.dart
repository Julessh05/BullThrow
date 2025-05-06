import 'dart:collection' show UnmodifiableListView;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:bull_throw/models/player.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Offset,
        RenderBox,
        TapDownDetails,
        TransformationController;
import 'package:vector_math/vector_math.dart';

final class X01Bloc extends Bloc {
  final UnmodifiableListView<Player> _players;

  UnmodifiableListView<Player> get players => _players;

  X01Bloc(this._players);

  int? getPointsForPosition(final Player player, final int position) {
    if (player.throws.length - position < 0) {
      return null;
    }
    return player.throws[player.throws.length - position].score;
  }

  void processThrow(
    TapDownDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    // Tippposition auf dem Bildschirm:
    final globalOffset = details.globalPosition;

    // Kontext des CustomPaint holen:
    final RenderBox box = context.findRenderObject() as RenderBox;
    final localOffset = box.globalToLocal(globalOffset);

    // Transformationsmatrix des InteractiveViewer zurückrechnen:
    final Matrix4 matrix = controller.value;
    final Matrix4 inverseMatrix = Matrix4.inverted(matrix);
    final Vector3 transformed = inverseMatrix.transform3(
      Vector3(localOffset.dx, localOffset.dy, 0),
    );

    final Offset dartboardPosition = Offset(transformed.x, transformed.y);
  }

  @override
  void dispose() {}
}

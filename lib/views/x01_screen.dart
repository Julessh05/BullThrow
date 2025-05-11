import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:bull_throw/blocs/x01_bloc.dart';
import 'package:bull_throw/models/player.dart';
import 'package:bull_throw/views/components/dartboard_painter.dart';
import 'package:flutter/material.dart';
import 'package:modern_themes/modern_themes.dart' show Themes;

final class X01Screen extends StatefulWidget {
  const X01Screen({super.key});

  @override
  State<X01Screen> createState() => _X01ScreenState();
}

final class _X01ScreenState extends State<X01Screen> {
  X01Bloc? _bloc;

  /// Controller for Interactive Viewer in Dartboard used for zooming and calculation of tap position
  final TransformationController _transformationController =
      TransformationController();

  @override
  Widget build(BuildContext context) {
    _bloc ??= BlocParent.of(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("X01"), automaticallyImplyLeading: true),
      body: Column(
        children: [
          SizedBox(
            height: size.height / 2,
            width: size.height / 2,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: _dartsBoard,
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: _bloc!.players.length,
              itemBuilder: (context, counter) {
                return _buildPlayerTile(_bloc!.players[counter]);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Returns the darts board, placed in the upper part of the screen
  Widget get _dartsBoard {
    return GestureDetector(
      onTapDown:
          (tapDetails) => setState(
            () => _bloc!.processThrow(
              tapDetails,
              context,
              _transformationController,
            ),
          ),
      child: InteractiveViewer(
        minScale: 1,
        maxScale: 7,
        scaleEnabled: true,
        transformationController: _transformationController,
        child: CustomPaint(
          isComplex: false,
          willChange: true,
          painter: DartboardPainter(Themes.themeMode),
        ),
      ),
    );
  }

  /// Builds a single player tile for the provided player
  Column _buildPlayerTile(final Player player) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(player.name, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                player.points.toString(),
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildThrowContainer(player, 3),
            _buildThrowContainer(player, 2),
            _buildThrowContainer(player, 1),
          ],
        ),
      ],
    );
  }

  /// Builds the container displaying the points thrown by the player
  Container _buildThrowContainer(final Player player, final int position) {
    final Object? textObj = _bloc!.getPointsForPosition(player, position);
    final String text = textObj != null ? textObj.toString() : "";
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        shape: BoxShape.rectangle,
        color: Colors.black12,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: text.isEmpty ? FontWeight.w400 : FontWeight.normal,
        ),
      ),
    );
  }
}

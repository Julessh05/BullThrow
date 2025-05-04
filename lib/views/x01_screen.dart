import 'package:bloc_implementation/bloc_implementation.dart';
import 'package:bull_throw/blocs/x01_bloc.dart';
import 'package:bull_throw/models/player.dart';
import 'package:bull_throw/views/components/DartboardPainter.dart';
import 'package:flutter/material.dart';

final class X01Screen extends StatefulWidget {
  const X01Screen({super.key});

  @override
  State<X01Screen> createState() => _X01ScreenState();
}

final class _X01ScreenState extends State<X01Screen> {
  X01Bloc? _bloc;

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
              padding: const EdgeInsets.all(12.0),
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
    return CustomPaint(painter: DartboardPainter());
  }

  /// Builds a single player tile for the provided player
  Column _buildPlayerTile(final Player player) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(player.name), Text(player.points.toString())],
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
  Container _buildThrowContainer(final Player player, int position) {
    return Container(
      child: Text(
        _bloc!.getPointsForPosition(player, position).toString() ?? "",
      ),
    );
  }
}

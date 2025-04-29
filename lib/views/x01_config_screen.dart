import 'package:bull_throw/models/player.dart';
import 'package:flutter/material.dart';

class X01ConfigScreen extends StatefulWidget {
  const X01ConfigScreen({super.key});

  @override
  State<X01ConfigScreen> createState() => _X01ConfigScreenState();
}

final class _X01ConfigScreenState extends State<X01ConfigScreen> {
  final List<Player> _players = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Game"), automaticallyImplyLeading: true),
      body: ListView.builder(
        itemCount: _players.length,
        itemBuilder: (context, counter) {
          // Add option to add new player at the end of the list
          if (counter == _players.length - 1) {
            return TextField(
              onSubmitted: (submittedName) {
                _players.add(Player(submittedName));
              },
            );
          } else {
            return Text(_players[counter].name);
          }
        },
      ),
    );
  }
}
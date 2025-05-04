import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:bull_throw/blocs/x01_config_bloc.dart';
import 'package:bull_throw/errors/duplicate_name_error.dart';
import 'package:bull_throw/errors/empty_player_name.dart';
import 'package:bull_throw/models/player.dart';
import 'package:bull_throw/routes.dart';
import 'package:flutter/material.dart';

/// The config screen for an X01 Game
final class X01ConfigScreen extends StatefulWidget {
  const X01ConfigScreen({super.key});

  @override
  State<X01ConfigScreen> createState() => _X01ConfigScreenState();
}

final class _X01ConfigScreenState extends State<X01ConfigScreen> {
  X01ConfigBloc? _bloc;

  /// Text editing controller to clear the text field after adding a new player
  final TextEditingController _playerNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _bloc ??= BlocParent.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("New Game"), automaticallyImplyLeading: true),
      body: _body,
    );
  }

  /// Returns the body of this view
  Padding get _body {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16, bottom: 0, left: 12, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Initial points", style: TextStyle(fontSize: 16)),
                DropdownButton<int>(
                  hint: Text("Points"),
                  value: _bloc!.points,
                  items: [
                    DropdownMenuItem(value: 301, child: Text(301.toString())),
                    DropdownMenuItem(value: 501, child: Text(501.toString())),
                    DropdownMenuItem(value: 701, child: Text(701.toString())),
                    DropdownMenuItem(value: 1001, child: Text(1001.toString())),
                  ],
                  onChanged: (newValue) {
                    setState(() {
                      _bloc!.updatePoints(newValue!);
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Divider(thickness: 0.5, color: Colors.grey.shade400),
          ),
          Flexible(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    "Player",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                _playerList,
                TextButton(
                  onPressed: () {
                    if (_bloc!.players.isNotEmpty) {
                      Navigator.of(
                        context,
                      ).pushNamed(Routes.x01, arguments: _bloc!.players);
                    } else {
                      // TODO: handle empty List
                    }
                  },
                  child: Text("Start Game"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Returns the list of players
  Widget get _playerList {
    return Flexible(
      child: Column(
        children: [
          _newPlayerTextField,
          Flexible(
            child: ListView.builder(
              itemCount: _bloc!.players.length,
              itemBuilder: (context, counter) {
                return _buildPlayerContainer(_bloc!.players[counter]);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Returns the text field to add a new player via entering the name
  Padding get _newPlayerTextField {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(labelText: "New Player Name"),
        controller: _playerNameController,
        onSubmitted: (submittedName) {
          setState(() {
            try {
              _bloc!.addNewPlayer(submittedName);
            } on EmptyPlayerNameError catch (_) {
              // TODO: handle empty player name error
            } on DuplicateNameError catch (_) {
              // TODO: handle duplicate name error
            }
            _playerNameController.text = "";
          });
        },
      ),
    );
  }

  /// Builds the container for a single provided player to display in the [_playerList]
  Padding _buildPlayerContainer(final Player player) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(player.name),
              IconButton(
                onPressed: () {
                  setState(() {
                    _bloc!.removePlayer(player);
                  });
                },
                icon: Icon(Icons.highlight_remove),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:bloc_implementation/bloc_implementation.dart';
import 'package:bull_throw/blocs/x01_config_bloc.dart';
import 'package:bull_throw/models/player.dart';
import 'package:flutter/material.dart';

class X01ConfigScreen extends StatefulWidget {
  const X01ConfigScreen({super.key});

  @override
  State<X01ConfigScreen> createState() => _X01ConfigScreenState();
}

final class _X01ConfigScreenState extends State<X01ConfigScreen> {
  X01ConfigBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc ??= BlocParent.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("New Game"), automaticallyImplyLeading: true),
      body: _body,
    );
  }

  Widget get _body {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Initial points"),
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
        SizedBox(
          height: size.height / 2,
          width: size.width,
          child: ListView.builder(
            itemCount: _bloc!.players.length,
            itemBuilder: (context, counter) {
              // Add option to add new player at the end of the list
              if (counter == _bloc!.players.length - 1) {
                return TextField(
                  onSubmitted: (submittedName) {
                    _bloc!.players.add(Player(submittedName));
                  },
                );
              } else {
                return Text(_bloc!.players[counter].name);
              }
            },
          ),
        ),
      ],
    );
  }
}
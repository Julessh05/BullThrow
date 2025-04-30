import 'package:bull_throw/routes.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BullThrow"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.settings);
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("X01"),
            onTap: () {
              Navigator.of(context).pushNamed(Routes.x01Config);
            },
          ),
          ListTile(title: Text("Cricket")),
          ListTile(title: Text("Around the clock")),
          ListTile(title: Text("Killer")),
          ListTile(title: Text("Shanghai")),
        ],
      ),
    );
  }
}
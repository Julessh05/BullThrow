import 'package:flutter/material.dart';

final class X01Screen extends StatelessWidget {
  const X01Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("X01"),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Container(),
          ListView.builder(
              itemBuilder: (context, counter) {

              },
          )
        ],
      ),
    );
  }
}
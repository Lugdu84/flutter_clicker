import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var _score = 0;

  _onAdd() {
    setState(() {
      _score++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clicker Game'),
      ),
      body: Column(
        children: [
          Text('Score: $_score'),
          IconButton(onPressed: _onAdd, icon: Icon(Icons.plus_one))
        ],
      ),
    );
  }
}

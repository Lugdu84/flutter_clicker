import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var _clickCount = 0;
  var _isCounting = false;

  _clickButtonTouched() {
    setState(() {
      _clickCount++;
    });
  }

  _startGame() {
    setState(() {
      _isCounting = true;
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
          Text('Nombre de clics : $_clickCount'),
          if (!_isCounting)
            ElevatedButton(
                onPressed: _startGame, child: Text("Commencer la partie")),
          if (_isCounting)
            IconButton(
                onPressed: _clickButtonTouched, icon: Icon(Icons.plus_one))
        ],
      ),
    );
  }
}

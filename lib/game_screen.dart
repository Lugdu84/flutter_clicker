import 'dart:async';

import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var _clickCount = 0;
  var _bestScore = 0;
  var _isCounting = false;

  _clickButtonTouched() {
    setState(() {
      _clickCount++;
    });
  }

  _startGame() {
    setState(() {
      _clickCount = 0;
      _isCounting = true;
      Timer(const Duration(seconds: 10), _stopGame);
    });
  }

  _stopGame() {
    setState(() {
      _isCounting = false;
      if (_clickCount > _bestScore) {
        _bestScore = _clickCount;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clicker Game'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Meilleur score : $_bestScore"),
            Text('Nombre de clics : $_clickCount'),
            if (_isCounting)
              IconButton(
                  onPressed: _clickButtonTouched,
                  icon: const Icon(Icons.plus_one)),
            const Spacer(),
            if (!_isCounting)
              ElevatedButton(
                  onPressed: _startGame,
                  child: const Text("Commencer la partie")),
          ],
        ),
      ),
    );
  }
}

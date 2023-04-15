import 'dart:async';
import 'package:flutter/material.dart';
import 'model/game_result.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<GameResult> _gameResultList = [];
  var _clickCount = 0;
  var _bestScore = 0;
  var _isCounting = false;
  String? _currentPlayerNickname;
  String? _bestPlayerNickname;

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
      _gameResultList.add(GameResult(
          player: _currentPlayerNickname ?? "Anonyme", score: _clickCount));
      _gameResultList.sort();

      if (_clickCount > _bestScore) {
        _bestScore = _clickCount;
        _bestPlayerNickname = _currentPlayerNickname;
      }
    });
  }

  _onNickNameChanged(value) {
    setState(() {
      _currentPlayerNickname = value;
    });
  }

  Widget _generateItemBuilder(BuildContext context, int index) {
    final gameResult = _gameResultList[index];
    return Row(
      children: [
        Text(gameResult.player),
        Icon(Icons.military_tech),
        Text(gameResult.score.toString() + " clics"),
      ],
    );
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
            if (!_isCounting)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _currentPlayerNickname,
                  onChanged: _onNickNameChanged,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.words,
                  autofillHints: const [AutofillHints.givenName],
                  decoration: const InputDecoration(
                    labelText: 'Pseudo',
                  ),
                ),
              ),
            if (_bestScore > 0)
              Text(
                  "Meilleur score : $_bestScore par ${_bestPlayerNickname ?? "Anonyme"}"),
            Text("Joueur actuel : ${_currentPlayerNickname ?? "Anonyme"}"),
            Text('Nombre de clics : $_clickCount'),
            if (_isCounting)
              IconButton(
                  onPressed: _clickButtonTouched,
                  icon: const Icon(Icons.plus_one)),
            Expanded(
              child: ListView.builder(
                itemBuilder: _generateItemBuilder,
                itemCount: _gameResultList.length,
              ),
            ),
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

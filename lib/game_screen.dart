import 'dart:async';
import 'package:clicker/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'hall_of_fame_screen.dart';
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
          player: _currentPlayerNickname ?? S.of(context).anonymous,
          score: _clickCount));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appName),
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
                  decoration: InputDecoration(
                    labelText: S.of(context).nickname,
                  ),
                ),
              ),
            if (_bestScore > 0)
              Text(S.of(context).bestScore(
                  _bestScore,
                  _bestPlayerNickname ??
                      S.of(context).anonymous.toLowerCase())),
            Text(S.of(context).currentPlayer(
                _currentPlayerNickname ?? S.of(context).anonymous)),
            Text(S.of(context).clickCount(_clickCount)),
            if (_isCounting)
              IconButton(
                  onPressed: _clickButtonTouched,
                  icon: const Icon(Icons.plus_one)),
            if (!_isCounting)
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HallOfFameScreen(
                                gameResultList: _gameResultList)));
                  },
                  child: Text(S.of(context).hallOfFame)),
            const Spacer(),
            if (!_isCounting)
              ElevatedButton(
                  onPressed: _startGame,
                  child: Text(S.of(context).gameStartButton)),
          ],
        ),
      ),
    );
  }
}

import 'package:clicker/model/game_result.dart';
import 'package:flutter/material.dart';

import 'generated/l10n.dart';

class HallOfFameScreen extends StatelessWidget {
  final List<GameResult> gameResultList;
  const HallOfFameScreen({super.key, required this.gameResultList});

  Widget _generateItemBuilder(BuildContext context, int index) {
    final gameResult = gameResultList[index];
    return Row(
      children: [
        Text(gameResult.player),
        const Icon(Icons.military_tech),
        Text(S.of(context).gameResultScorePoints(gameResult.score)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).hallOfFame),
      ),
      body: Expanded(
        child: ListView.builder(
          itemBuilder: _generateItemBuilder,
          itemCount: gameResultList.length,
        ),
      ),
    );
  }
}

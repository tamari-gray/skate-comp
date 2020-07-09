import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:skate_comp/state.dart';

class FinishedGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ContestState>(builder: (context, contest, child) {
      final _skaters = contest.leaderboard;
      final String _winner = _skaters[0].name;
      return Scaffold(
        appBar: AppBar(
          title: Text("$_winner wins Yeet league!!"),
          automaticallyImplyLeading: false,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // reset game
            contest.reset();
            Phoenix.rebirth(context);
          },
          label: Text('Play again'),
          icon: Icon(Icons.navigate_next),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: _skaters.length,
            itemBuilder: (BuildContext context, int index) {
              final _position = index + 1;
              return Card(
                child: ListTile(
                  title: Text('$_position.  ${_skaters[index].name}'),
                  trailing: Text('${contest.skaters[index].totalScore}'),
                ),
              );
            }),
      );
    });
  }
}

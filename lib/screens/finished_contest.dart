import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:skate_comp/state.dart';

class FinishedGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeet league leaderboard"),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // reset game
          Provider.of<ContestState>(context, listen: false).reset();
          Phoenix.rebirth(context);
        },
        label: Text('Play again'),
        icon: Icon(Icons.navigate_next),
      ),
      body: Consumer<ContestState>(
        builder: (context, contest, child) {
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: contest.skaters.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text('${contest.skaters[index].name}'),
                    trailing: Text('${contest.skaters[index].totalScore}'),
                  ),
                );
              });
        },
      ),
    );
  }
}

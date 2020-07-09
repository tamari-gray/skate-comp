import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:yeetLeague/screens/finished_contest.dart';
import 'package:yeetLeague/screens/view_score.dart';
import 'package:yeetLeague/state.dart';

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  Future<void> _confirmLeaveDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to end the game?'),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text('End'),
              onPressed: () {
                Provider.of<ContestState>(context, listen: false).reset();
                Phoenix.rebirth(context);
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContestState>(builder: (context, contest, child) {
      final _skaters = contest.leaderboard;
      return Scaffold(
        appBar: AppBar(
          title: Text("Yeet league"),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            FlatButton(
              child: Text("End game"),
              onPressed: () async {
                await _confirmLeaveDialog();
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            //check if skaters have completed all attempts
            final bool allAttemptsComplete = contest.finishedGame;

            print("check if finished: $allAttemptsComplete");
            // if complete go to home
            if (allAttemptsComplete) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FinishedGame()),
              );
            } else if (allAttemptsComplete == false) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewScore()),
              );
            }
          },
          label: Text('Next'),
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
                trailing: Text('${_skaters[index].totalScore}'),
              ),
            );
          },
        ),
      );
    });
  }
}

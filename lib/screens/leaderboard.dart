import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skate_comp/state.dart';

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeet league"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          FlatButton(
            child: Text("End game"),
            onPressed: () {
              // reset game
              Provider.of<ContestState>(context, listen: false).reset();
              //route to lobby
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Text("leaderboard screen"),
      ),
    );
  }
}

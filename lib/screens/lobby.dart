import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yeetLeague/screens/add_skater.dart';
import 'package:yeetLeague/screens/leaderboard.dart';
import 'package:yeetLeague/state.dart';

class Lobby extends StatefulWidget {
  Lobby({
    Key key,
  }) : super(key: key);

  @override
  _LobbyState createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeet league"),
        actions: <Widget>[
          Consumer<ContestState>(
            builder: (context, contest, child) {
              return FlatButton(
                child: Text("Ready"),
                onPressed: () {
                  //route to leaderboard
                  if (contest.skaters.length > 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LeaderBoard()),
                    );
                  } else {
                    final snackBar =
                        SnackBar(content: Text('Add some peeps first'));

                    Scaffold.of(context).showSnackBar(snackBar);
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<ContestState>(
        builder: (context, contest, child) {
          return contest.skaters.length == 0
              ? Center(
                  child: Text(
                    'Who gon play today?',
                    style: TextStyle(fontSize: 30),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: contest.skaters.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text('${contest.skaters[index].name}'),
                        trailing: Icon(Icons.remove_circle),
                        onTap: () {
                          contest.removeSkater(contest.skaters[index].name);
                        },
                      ),
                    );
                  });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddSkater()),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

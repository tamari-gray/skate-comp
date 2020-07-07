import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skate_comp/screens/add_skater.dart';
import 'package:skate_comp/screens/leaderboard.dart';
import 'package:skate_comp/state.dart';

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
          FlatButton(
            child: Text("Ready"),
            onPressed: () {
              //route to leaderboard
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LeaderBoard()),
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
                ))
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

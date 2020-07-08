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
              //                   DO ARE YOU SURE POPUP v
              // reset game
              Provider.of<ContestState>(context, listen: false).reset();
              //route to lobby
              Navigator.pop(context);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // go to scoring route
        },
        label: Text('Next '),
        icon: Icon(Icons.navigate_next),
        // backgroundColor: Colors.pink,
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
                        // subtitle: Text('up next'),
                        trailing: Text('${contest.skaters[index].totalScore}'),
                        onTap: () {
                          contest.removeSkater(contest.skaters[index].name);
                        },
                      ),
                    );
                  });
        },
      ),
    );
  }
}

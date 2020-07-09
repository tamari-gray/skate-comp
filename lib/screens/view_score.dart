import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skate_comp/screens/add_score.dart';
import 'package:skate_comp/state.dart';

class ViewScore extends StatefulWidget {
  @override
  _ViewScoreState createState() => _ViewScoreState();
}

class _ViewScoreState extends State<ViewScore> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ContestState>(builder: (context, contest, child) {
      return contest.finishedGame
          ? Scaffold(
              body: Container(),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(
                    "${contest.currentSkater.name} total score = ${contest.currentSkater.totalScore} "),
                automaticallyImplyLeading: false,
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  // go to scoring route
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddScore()),
                  );
                },
                label: Text('Next'),
                icon: Icon(Icons.navigate_next),
              ),
              body: Container(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: contest.currentSkater.scores.length,
                    itemBuilder: (BuildContext context, int index) {
                      final _score = contest.currentSkater.scores.values
                                  .elementAt(index) !=
                              null
                          ? contest.currentSkater.scores.values.elementAt(index)
                          : 0;
                      return Card(
                        child: ListTile(
                          title: Text(
                              "${contest.currentSkater.scores.keys.elementAt(index)}"),
                          trailing: Text('$_score'),
                        ),
                      );
                    }),
              ),
            );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skate_comp/models/skater.dart';
import 'package:skate_comp/screens/leaderboard.dart';
import 'package:skate_comp/state.dart';

class AddScore extends StatefulWidget {
  @override
  _AddScoreState createState() => _AddScoreState();
}

class _AddScoreState extends State<AddScore> {
  double _hypeScore;
  double _funScore;
  double _flowScore;

  @override
  void initState() {
    super.initState();
    _hypeScore = 0;
    _funScore = 0;
    _flowScore = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContestState>(builder: (context, contest, child) {
      if (!contest.finishedGame) {
        final _skater = contest.currentSkater;
        Future<void> _submitScoreDialog(double score, String skaterName) async {
          return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Are you sure?'),
                actions: <Widget>[
                  RaisedButton(
                    child: Text('Yes'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LeaderBoard()),
                      );
                      Provider.of<ContestState>(context, listen: false)
                          .addScore(score, skaterName);
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

        return Scaffold(
          appBar: AppBar(
            title: Text("${_skater.name}  ${contest.currentAttemptName} "),
            automaticallyImplyLeading: false,
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              // go to scoring route
              final _totalScore = _hypeScore + _funScore + _flowScore;
              final _avgScore = _totalScore / 3;
              final _roundedScore = _avgScore.toStringAsFixed(1);
              final _finalScore = double.tryParse(_roundedScore);

              print("final score is $_finalScore");

              await _submitScoreDialog(_finalScore, _skater.name);
            },
            label: Text('Submit'),
            icon: Icon(Icons.navigate_next),
          ),
          body: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Hype",
                      style: TextStyle(fontSize: 30),
                    ),
                    Slider(
                      value: _hypeScore,
                      onChanged: (newValue) {
                        setState(() => _hypeScore = newValue);
                      },
                      min: 0,
                      max: 10,
                      divisions: 100,
                      label: "$_hypeScore",
                    )
                  ]),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Fun",
                        style: TextStyle(fontSize: 30),
                      ),
                      Slider(
                        value: _funScore,
                        onChanged: (newValue) {
                          setState(() => _funScore = newValue);
                        },
                        min: 0,
                        max: 10,
                        divisions: 100,
                        label: "$_funScore",
                      )
                    ]),
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Flow",
                      style: TextStyle(fontSize: 30),
                    ),
                    Slider(
                      value: _flowScore,
                      onChanged: (newValue) {
                        setState(() => _flowScore = newValue);
                      },
                      min: 0,
                      max: 10,
                      divisions: 100,
                      label: "$_flowScore",
                    )
                  ])
            ],
          )),
        );
      } else {
        return Scaffold(
          body: Container(
            child: Text("loading"),
          ),
        );
      }
    });
  }
}

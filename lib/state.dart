import 'package:flutter/material.dart';
import 'package:skate_comp/models/skater.dart';

class ContestState extends ChangeNotifier {
  final List<Skater> _skaters = [];
  int currentAttempt = 1;
  String currentAttemptName = "run_1";

  // scoring
  void nextAttempt() {
    currentAttempt++;
    setAttemptName();
  }

  void setAttemptName() {
    switch (currentAttempt) {
      case 1:
        currentAttemptName = "run_1";
        break;
      case 2:
        currentAttemptName = "run_2";
        break;
      case 3:
        currentAttemptName = "trick_1";
        break;
      case 4:
        currentAttemptName = "trick_2";
        break;
      case 5:
        currentAttemptName = "trick_3";
        break;
      case 6:
        currentAttemptName = "trick_4";
        break;
      case 7:
        currentAttemptName = "trick_5";
        break;
      default:
        currentAttemptName = "run_1";
    }
  }

  void addScore(double score, String skaterName) {
    final Skater _skater =
        _skaters.firstWhere((skater) => skater.name == skaterName);

    _skater.scores[currentAttemptName] = score;
    print(
        "added ${_skater.name} $currentAttemptName score: ${_skater.scores[currentAttemptName]}");

    // check if everyone has completed this attempt then go to next attempt
    final bool everySkaterHasCompletedAttempt =
        _skaters.every((skater) => skater.scores[currentAttemptName] != null);
    if (everySkaterHasCompletedAttempt) nextAttempt();
    notifyListeners();
  }

  Skater get currentSkater {
    // get skater
    final _currentSkater = _skaters
        .firstWhere((skater) => skater.scores[currentAttemptName] == null);
    print("${_currentSkater.name}");
    return _currentSkater;
  }

  // get skaters
  List<Skater> get skaters => _skaters;

  // get skaters in order of score
  // void orderSkaters() {
  //   _skaters.sort((a, b) => a.totalScore.compareTo(b.totalScore));
  //   notifyListeners();
  // }

  // add new skater
  void addSkater(String name) {
    _skaters.add(Skater(name: name));
    notifyListeners();
  }

  // remove skater
  void removeSkater(String name) {
    print("removing skater");
    _skaters.removeWhere((skater) => skater.name == name);
    notifyListeners();
  }

  // reset contest
  void reset() {
    _skaters.clear();
    notifyListeners();
  }
}
// update skater score

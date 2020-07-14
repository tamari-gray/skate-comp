// Import the test package and Counter class
import 'package:yeetLeague/state.dart';
import 'package:test/test.dart';

void main() {
  test('figure out whos turn it is, then add score for that skater', () {
    final contest = ContestState();

    contest.addSkater("pete");
    contest.addSkater("po");
    contest.addSkater("poster");
    expect(contest.skaters[1].name, equals("po"));

    expect(contest.currentAttempt, equals(1));

    final _currentSkater = contest.currentSkater;
    expect(_currentSkater.name, equals("pete"));

    contest.addScore(9.2, _currentSkater.name);
    final skaterThatJustGotScored =
        contest.skaters.firstWhere((skater) => skater.name == "pete");
    expect(skaterThatJustGotScored.scores["run 1"], equals(9.2));

    final _nextSkater = contest.currentSkater;
    expect(_nextSkater.name, equals("po"));

    contest.addScore(9.5, contest.currentSkater.name);
    final newSkaterThatJustGotScored =
        contest.skaters.firstWhere((skater) => skater.name == "po");
    expect(newSkaterThatJustGotScored.scores["run 1"], equals(9.5));

    expect(contest.currentSkater.name, equals("poster"));
  });

  test('add scores to consecutive attempts', () {
    //set up
    final contest = ContestState();
    contest.addSkater("pete");
    contest.addSkater("po");
    expect(contest.currentAttempt, equals(1));

    // add pete 1st score
    contest.addScore(9.0, contest.currentSkater.name);
    expect(contest.currentAttempt, equals(1));

    // add po first score
    contest.addScore(6.5, contest.currentSkater.name);
    expect(contest.currentAttempt, equals(2));

    // add pete second score
    contest.addScore(8.0, contest.currentSkater.name);
    expect(contest.currentAttempt, equals(2));

    // add po second score
    contest.addScore(8.2, contest.currentSkater.name);
    expect(contest.currentAttempt, equals(3));

    // add pete third score
    contest.addScore(9.0, contest.currentSkater.name);
    expect(contest.currentAttempt, equals(3));
  });

  test('check if game finished', () {
    final contest = ContestState();
    contest.addSkater("pete");
    contest.addSkater("po");
    for (var i = 0; i < 14; i++) {
      contest.addScore(9.0, contest.currentSkater.name);
    }

    expect(contest.finishedGame, true);
  });
  test('total score is top 4 scores', () {
    final contest = ContestState();
    contest.addSkater("pete");
    contest.addSkater("po");

    contest.addScore(9.0, contest.skaters[0].name);
    expect(contest.skaters[0].totalScore, 9.0);
    contest.addScore(9.0, contest.skaters[1].name);
    expect(contest.skaters[1].totalScore, 9.0);

    contest.addScore(6.0, contest.skaters[0].name);
    expect(contest.skaters[0].totalScore, 15.0);
    contest.addScore(6.0, contest.skaters[1].name);
    expect(contest.skaters[1].totalScore, 15.0);

    contest.addScore(0, contest.skaters[0].name);
    expect(contest.skaters[0].totalScore, 15.0);
    contest.addScore(0, contest.skaters[1].name);
    expect(contest.skaters[1].totalScore, 15.0);

    contest.addScore(9.5, contest.skaters[0].name);
    expect(contest.skaters[0].totalScore, 24.5);
    contest.addScore(9.5, contest.skaters[1].name);
    expect(contest.skaters[1].totalScore, 24.5);

    contest.addScore(9.4, contest.skaters[0].name);
    expect(contest.skaters[0].totalScore, 33.9);
    contest.addScore(9.4, contest.skaters[1].name);
    expect(contest.skaters[1].totalScore, 33.9);

    contest.addScore(9.1, contest.skaters[0].name);
    expect(contest.skaters[0].totalScore, 37.0);
    contest.addScore(9.1, contest.skaters[1].name);
    expect(contest.skaters[1].totalScore, 37.0);

    contest.addScore(9.9, contest.skaters[0].name);
    contest.addScore(9.8, contest.skaters[1].name);
    expect(contest.skaters[0].totalScore, 37.9);
    expect(contest.skaters[1].totalScore, 37.800000000000004);
  });
  test('get skaters in order of scores', () {
    final contest = ContestState();
    contest.addSkater("pete");
    contest.addSkater("po");
    contest.addSkater("toto");
    for (var i = 0; i < 21; i++) {
      if (contest.currentSkater.name == "pete") {
        contest.addScore(9.0, contest.currentSkater.name);
      } else if (contest.currentSkater.name == "po") {
        contest.addScore(5.0, contest.currentSkater.name);
      } else if (contest.currentSkater.name == "toto") {
        contest.addScore(9.5, contest.currentSkater.name);
      }
    }
    expect(contest.finishedGame, true);

    expect(contest.leaderboard[0].name, equals("toto"));
    expect(contest.leaderboard[1].name, equals("pete"));
    expect(contest.leaderboard[2].name, equals("po"));
  });
}

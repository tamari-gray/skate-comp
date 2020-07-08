// Import the test package and Counter class
import 'package:skate_comp/state.dart';
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
    expect(skaterThatJustGotScored.scores["run_1"], equals(9.2));

    final _nextSkater = contest.currentSkater;
    expect(_nextSkater.name, equals("po"));

    contest.addScore(9.5, contest.currentSkater.name);
    final newSkaterThatJustGotScored =
        contest.skaters.firstWhere((skater) => skater.name == "po");
    expect(newSkaterThatJustGotScored.scores["run_1"], equals(9.5));

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
    contest.addScore(9.9, contest.currentSkater.name);
    expect(contest.currentAttempt, equals(3));
  });
}

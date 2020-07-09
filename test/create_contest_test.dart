// Import the test package and Counter class
import 'package:yeetLeague/state.dart';
import 'package:test/test.dart';

void main() {
  test('adding skater increases player count', () {
    final contest = ContestState();
    final startingPlayerCount = contest.skaters.length;
    expect(startingPlayerCount, equals(0));
    contest.addListener(() {
      expect(contest.skaters.length, greaterThan(startingPlayerCount));
    });
    contest.addSkater("pete");
  });

  test('removing skater decreases player count', () {
    final contest = ContestState();
    contest.addSkater("po");
    contest.addSkater("pete");
    final startingPlayerCount = contest.skaters.length;
    expect(startingPlayerCount, equals(2));
    contest.addListener(() {
      expect(contest.skaters.length, lessThan(startingPlayerCount));
      expect(contest.skaters[0].name, equals("pete"));
    });
    contest.removeSkater("po");
  });

  test(" reset contest deletes all players", () {
    final contest = ContestState();
    contest.addSkater("po");
    contest.addSkater("pete");
    final startingPlayerCount = contest.skaters.length;
    expect(startingPlayerCount, equals(2));
    contest.addListener(() {
      expect(contest.skaters.length, equals(0));
    });
    contest.reset();
  });
}

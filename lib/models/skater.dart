class Skater {
  final String name;
  Map<String, int> scores = {
    run_1: 0,
    run_2: 0,
    trick_1: 0,
    trick_2: 0,
    trick_3: 0,
    trick_4: 0,
    trick_5: 0,
  };
  int get totalScore => scores.values.reduce((sum, score) => sum + score);

  Skater({this.name});
}

final String run_1 = "run-1";
final String run_2 = "run-2";
final String trick_1 = "trick-1";
final String trick_2 = "trick-2";
final String trick_3 = "trick-3";
final String trick_4 = "trick-4";
final String trick_5 = "trick-5";

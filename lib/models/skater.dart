class Skater {
  final String name;
  Map<String, double> scores = {
    run_1: null,
    run_2: null,
    trick_1: null,
    trick_2: null,
    trick_3: null,
    trick_4: null,
    trick_5: null,
  };

  double get totalScore {
    bool noAttemptsYet = scores.values.every((element) => element == null);

    if (noAttemptsYet) {
      return 0.0;
    } else {
      return scores.values
          .where((attempt) => attempt != null)
          .reduce((value, element) => value + element);
    }
  }

  Skater({this.name});
}

final String run_1 = "run 1";
final String run_2 = "run 2";
final String trick_1 = "trick 1";
final String trick_2 = "trick 2";
final String trick_3 = "trick 3";
final String trick_4 = "trick 4";
final String trick_5 = "trick 5";

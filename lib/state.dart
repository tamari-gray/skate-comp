import 'package:flutter/material.dart';
import 'package:skate_comp/models/skater.dart';

class ContestState extends ChangeNotifier {
  final List<Skater> _skaters = [];

  // get skaters
  List<Skater> get skaters => _skaters;

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

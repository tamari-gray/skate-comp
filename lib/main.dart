import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skate_comp/screens/lobby.dart';
import 'package:skate_comp/state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContestState(),
      child: MaterialApp(
        title: 'Yeet league',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Lobby(),
      ),
    );
  }
}
import 'package:build_cntext_deep/presentation/screens/home_screen.dart';
import 'package:build_cntext_deep/presentation/screens/second_screen.dart';
import 'package:build_cntext_deep/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';


class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(
            title: "Home Screen",
            color: Colors.indigo.shade600,
          ),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (_) => SecondScreen(
            title: "Second Screen",
            color: Colors.black,
          ),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (_) => ThirdScreen(
            title: "Thirst Screen",
            color: Colors.greenAccent,
          ),
        );
      default:
        return null;
    }
  }
}

import 'package:fee_sheets/presentation/Screens/formScreen.dart';
import 'package:fee_sheets/presentation/Screens/listScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => FormScreen(),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (_) => ListScreen(),
        );

      default:
        return null;
    }
  }
}

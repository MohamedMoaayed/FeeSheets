import 'package:fee_sheets/domain/list_bloc/list_bloc.dart';
import 'package:fee_sheets/presentation/Screens/splashScreen.dart';
import 'package:fee_sheets/presentation/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/form_bloc/form_bloc.dart';
import 'infrastructure/locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FormBloc>(
          create: (BuildContext context) => FormBloc(),
        ),
        BlocProvider<ListBloc>(
          create: (BuildContext context) => ListBloc(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: _appRouter.onGenerateRoute,
        theme: ThemeData(
          primaryColor: Colors.white,
          fontFamily: 'Gilory',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

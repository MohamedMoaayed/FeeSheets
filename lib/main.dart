import 'package:fee_sheets/presentation/Screens/formScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'domain/form_bloc/form_bloc.dart';
import 'infrastructure/locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FormBloc>(
          create: (BuildContext context) => FormBloc(),
        ),
      ],
      child: GetMaterialApp(
        theme: ThemeData(
          primaryColor: Colors.white,
          fontFamily: 'Gilory',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FormPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

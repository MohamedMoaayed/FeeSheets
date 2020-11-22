import 'dart:ui';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fee_sheets/domain/form_bloc/form_bloc.dart';
import 'package:fee_sheets/infrastructure/locator.dart';
import 'package:fee_sheets/infrastructure/savedValues.dart';

import 'package:fee_sheets/presentation/Widgets/textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final _form = GlobalKey<FormState>();

class FormPage extends StatelessWidget {
  const FormPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormBloc, FormScreenState>(listener: (context, state) {
      // Listen to an error if occurred
      if (state is FormError) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
          ),
        );
      }
    }, builder: (context, state) {
      // return widget here based on Bloc's state
      if (state is FormInitial) {
        return buildScaffold(context);
      } else {
        return buildScaffold(context);
      }
    });
  }
}

Scaffold buildScaffold(BuildContext context) {
  return Scaffold(
    bottomNavigationBar: BottomNavyBar(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      //  selectedIndex: _selectedIndex,
      showElevation: true, // use this to remove appBar's elevation
      onItemSelected: (index) => print("object"),
      items: [
        BottomNavyBarItem(
          icon: Icon(Icons.add),
          title: Text('Form'),
          activeColor: Colors.red,
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.list_alt_rounded),
            title: Text('Changes'),
            activeColor: Colors.green),
      ],
    ),
    appBar: AppBar(
      title: Text.rich(TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.bold,
          fontSize: 40,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Fee',
            style: TextStyle(color: Color.fromRGBO(251, 219, 91, 100)),
          ),
          TextSpan(
            text: 'Sheets',
            style: TextStyle(
              color: Color.fromRGBO(59, 159, 108, 100),
            ),
          ),
        ],
      )),
      elevation: 00,
    ),
    body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Column(
                children: [
                  Text(
                    'Hello User',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w200,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    'Please fill out this form',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CutstomTextField(
                        textFieldName: 'Name',
                        hintText: 'What we can call you?',
                        onSaved: (val) => locator<SavedValues>().setname(val),
                      ),
                      CutstomTextField(
                        textFieldName: 'Mobile Number',
                        hintText: "Let's be in touch",
                        onSaved: (val) => locator<SavedValues>().setmobile(val),
                      ),
                      CutstomTextField(
                        textFieldName: 'Model Number',
                        hintText: '#XXXXXXXX',
                        onSaved: (val) => locator<SavedValues>().setmodel(val),
                      ),
                      CutstomTextField(
                        textFieldName: 'Purchase Date',
                        hintText: 'DD/MM/YYYY',
                        onSaved: (val) => locator<SavedValues>().setdate(val),
                      ),
                      CutstomTextField(
                        textFieldName: 'Email',
                        hintText: 'example@website.com',
                        onSaved: (val) => locator<SavedValues>().setemail(val),
                      ),

                      // Putting all the widgets togather.
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(
                builder: (context) => FlatButton(
                    minWidth: MediaQuery.of(context).size.width - 50,
                    padding: const EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Color.fromRGBO(59, 159, 108, 100),
                    child: Text(
                      'Submit to Google Sheets',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          color: Colors.yellow,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    onPressed: () {
                      _form.currentState.save();

                      final FormBloc counterBloc =
                          BlocProvider.of<FormBloc>(context);
                      final formBloc = context.bloc<FormBloc>();
                      formBloc.add(SubmitEvent());
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Yay! we recived your Info. Thanks!"),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

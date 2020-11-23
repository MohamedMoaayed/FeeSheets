import 'package:fee_sheets/domain/list_bloc/list_bloc.dart';
import 'package:fee_sheets/presentation/Screens/formScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: BlocConsumer<ListBloc, ListState>(
        listener: (context, state) {
          // Listen to an error if occurred
          if (state is ListError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          // return widget here based on Bloc's state
          if (state is ListInitial) {
            return buildCards();
          } else if (state is ListLoading) {
            return buildScaffold(context);
          }
          {
            return buildScaffold(context);
          }
        },
      ),
    );
  }

  Widget buildCards() {
    return ListView.builder(
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        // height: 220,
        width: double.maxFinite,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(3),
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    // width: 300,
                    child: Text(
                      'Name',
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.phone),
                      Container(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'Mobile number',
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.date_range),
                      Container(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'Date',
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w300,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.confirmation_number),
                      Container(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'Model Number',
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.email),
                      Container(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'E-mail',
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  FlatButton(
                      padding: const EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Color.fromRGBO(59, 159, 108, 100),
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          Text(
                            'Delete this Row',
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                color: Colors.redAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      onPressed: () {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Yay! we recived your Info. Thanks!"),
                          ),
                        );
                      }),
                ],
              )),
        ),
      ),
    );
  }
}

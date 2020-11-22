import 'package:flutter/material.dart';

class CutstomTextField extends StatelessWidget {
  final String textFieldName;
  final String hintText;
  final Function onSaved;
  const CutstomTextField({
    Key key,
    @required this.textFieldName,
    @required this.hintText,
    @required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textFieldName,
            style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 12,
          ),
          TextFormField(
            onSaved: onSaved,
            decoration: InputDecoration(
              fillColor: Color.fromRGBO(231, 236, 246, 100),
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none),
              hintText: hintText,
              hintStyle: TextStyle(fontFamily: 'Gilroy'),
            ),
          ),
        ],
      ),
    );
  }
}

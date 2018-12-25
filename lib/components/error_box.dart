import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  final bool isError;
  final String errorText;
  ErrorBox({this.isError, this.errorText});

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return new Container(
          margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          decoration: new BoxDecoration(
              border: const Border(
                top: const BorderSide(
                    width: 1.0, color: const Color(0xFF48B5B0)),
                left: const BorderSide(
                    width: 1.0, color: const Color(0xFF48B5B0)),
                right: const BorderSide(
                    width: 1.0, color: const Color(0xFF48B5B0)),
                bottom: const BorderSide(
                    width: 1.0, color: const Color(0xFF48B5B0)),
              ),
              borderRadius: new BorderRadius.circular(32.0)),
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: new Center(
            child: new Text(
              errorText ?? '',
              style: new TextStyle(color: Color(0xFF48B5B0)),
            ),
          ));
    } else {
      return Container();
    }
  }
}

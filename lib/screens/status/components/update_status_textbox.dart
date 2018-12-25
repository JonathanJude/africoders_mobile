import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';

class UpdateStatusTextBox extends StatelessWidget {
  final TextEditingController statusTextController;
  final VoidCallback onPressed;
  UpdateStatusTextBox({this.statusTextController, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: TextField(
              autocorrect: true,
              maxLines: 4,
              controller: statusTextController,
              style: TextStyle(
                //color: Color(0xFF98daac),
                color: Colors.white,
                fontSize: 14.0,
              ),
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    gapPadding: 18.0,
                    borderSide: BorderSide(
                        color: Color(0xFF9CE0AD),
                        //color: Color(0xFF48b5b0),
                        style: BorderStyle.solid,
                        width: 1.0),
                  ),
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: 'Whats is the latest?..',
                  hintStyle: TextStyle(
                      //color: Color(0xFF98daac),
                      color: Colors.white,
                      fontSize: 14.0,
                      fontStyle: FontStyle.italic),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    gapPadding: 18.0,
                    borderSide: BorderSide(
                        color: Color(0xFF48b5b0),
                        style: BorderStyle.solid,
                        width: 1.0),
                  ),
                  filled: true,
                  fillColor: mainBgColor),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: clickButton(
                text: 'Share Status',
                onPressed: onPressed,
                iconExists: true,
                icon: Icons.add),
          )
        ],
      ),
    );
  }
}

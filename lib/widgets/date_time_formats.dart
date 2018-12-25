import 'package:intl/intl.dart';

String dateAndTimeFormatter(String dateTimeString) {
  var dateTime = DateTime.parse(dateTimeString);
  //var formatter = new DateFormat('yyyy-MM-dd');
  var formatter = new DateFormat('E, d MMM, y ').add_jm();
  String formatted = formatter.format(dateTime);
  return formatted;
}

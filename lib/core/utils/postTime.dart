import 'package:intl/intl.dart';

String timeFromNow(int postTime) {

  DateTime postTimeDate = DateTime.fromMillisecondsSinceEpoch(postTime);

  DateTime now = DateTime.now();
  var difference = now.difference(postTimeDate);

  if (difference < Duration(minutes: 1)) {
    return "przed chwilą";
  }
  else if  (difference < Duration(minutes: 60)){
    return "${difference.inMinutes} min";
  } else if (difference < Duration(hours: 24)) {
    return "${difference.inHours} h";
  } else return
    DateFormat("dd MMMM o HH:mm ").format(postTimeDate);

  //return difference.inSeconds;
}
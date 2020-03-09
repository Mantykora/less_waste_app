import 'package:flutter_test/flutter_test.dart';
import 'package:less_waste_app/core/utils/postTime.dart';

void main() {
  DateTime now = DateTime.now();
  test('text should be 1 min', () {
    int postTime = now.subtract(Duration(minutes: 1)).millisecondsSinceEpoch;

    String timeText = timeFromNow(postTime);

    expect(timeText, "1 min");
  });

  test('text should be przed chwilą', () {
    int postTime = now.subtract(Duration(seconds: 30)).millisecondsSinceEpoch;

    String timeText = timeFromNow(postTime);

    expect(timeText, "przed chwilą");
  });

  test('text should be 59 min', () {
    int postTime = now.subtract(Duration(minutes: 59)).millisecondsSinceEpoch;

    String timeText = timeFromNow(postTime);

    expect(timeText, "59 min");
  });

  test('text should be 1 hour', () {
    int postTime = now.subtract(Duration(hours: 1)).millisecondsSinceEpoch;

    String timeText = timeFromNow(postTime);

    expect(timeText, "1 h");
  });

  test('text should be 23 hour', () {
    int postTime = now.subtract(Duration(hours: 23)).millisecondsSinceEpoch;

    String timeText = timeFromNow(postTime);

    expect(timeText, "23 h");
  });


}

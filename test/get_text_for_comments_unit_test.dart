import 'package:flutter_test/flutter_test.dart';
import 'package:less_waste_app/core/utils/get_text_for_comments.dart';

void main() {
  test('there should be correct declination for /"komentarze/"', () {
    int count = 1;
    String text = getTextForCommentsCount(count);
    expect(text, " komentarz");
  });

  test('there should be correct declination for /"komentarze/"', () {
    int count = 2;
    String text = getTextForCommentsCount(count);
    expect(text, " komentarze");
  });

  test('there should be correct declination for /"komentarze/"', () {
    int count = 5;
    String text = getTextForCommentsCount(count);
    expect(text, " komentarzy");
  });
}

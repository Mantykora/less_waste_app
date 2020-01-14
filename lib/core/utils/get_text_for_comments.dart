String getTextForCommentsCount(int count) {
  var text;
  if (count == null) {
    text = "";
  } else if (count == 1) {
    text = " komentarz";
  } else if (count == 0 || count > 4) {
    text = " komentarzy";
  } else {
    text = " komentarze";
  }
  return text;
}

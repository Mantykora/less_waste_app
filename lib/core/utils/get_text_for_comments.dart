String getTextForCommentsCount(int count) {
  var text;
  if (count == null) {
    text = "";
  } else if (count == 1) {
    text = " komentarz";
  } else {
    text = " komentarze";
  }
  return text;
}

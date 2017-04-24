int hash (String string) {
  int h = 7;
  for (int i = 0; i < string.length(); i++) {
    h = h*31 + string.charAt(i);
  }
  return h;
}
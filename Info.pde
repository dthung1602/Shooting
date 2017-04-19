class Info {
  String message;
  int x, y;
  color cl;
  PFont font;
  
  Info (String message, int x, int y, color cl, PFont font) {
    this.message = message;
    this.x = x;
    this.y = y;
    this.cl = cl;
    this.font = font;
  }
  
  void show () {
    textFont(font);
    fill(cl);
    text(message, x, y);
  }
}
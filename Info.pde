class Info {
  String message;
  int x, y;
  color cl;
  PFont font;
  boolean hiden = false;
  
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
    if (!hiden)
      text(message, x, y);
    else {
      String s = "";
      for (int i=0; i<message.length(); i++) 
        s += '*';
      text(s, x, y);
    }
  }
}
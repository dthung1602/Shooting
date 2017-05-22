class Info {
  String message;
  int x, y;
  color cl;
  PFont font;
  boolean hidden = false;
  boolean input = false;
  
  Info (String message, int x, int y, color cl, PFont font) {
    this.message = message;
    this.x = x;
    this.y = y;
    this.cl = cl;
    this.font = font;
  }
  
  Info() {
  }
  
  void show () {
    if (message == null)
      return;
    
    textFont(font);
    fill(cl);
    String s = message;
    
    // if hidden, turn content into ***
    if (hidden) {
      s = "";
      for (int i=0; i<message.length(); i++) 
        s += '*';
    }
    
    // add | at the end
    if (input) 
      s += "|";
    
    text(s, x, y);
  }
}

class TimeInfo extends Info {
  int time;
  TimeInfo (String message, int x, int y, color cl, PFont font, int time) {
    super(message, x, y, cl, font);
    this.time = time;
  }
  
  void show() {
    if (time == 0) 
      return;
    super.show();
    if (time > 0) 
      time--;
  }
}
abstract class Screen {
  PImage bg;
  Button buttonList[];
  
  Screen () {}
  
  void show() {
    background(bg);
  };
}

// >>>>create lose screen, win screen, upgrade
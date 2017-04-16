class Screen {
  PImage bg;
  Button buttonList[];
  
  Screen (PImage bg, Button buttonList[]) {
    this.bg = bg;
    this.buttonList = buttonList;
  }
  
  void show () {
    background(bg);
    
    //high light if mouse on any button
    Button b;
    for (int i=0; i<buttonList.length; i++) {
      b = screen.buttonList[i]; 
      if (b.containPoint(mouseX, mouseY) && b.enable) {
        noStroke();
        fill(BLUE);
        rect(b.x1, b.y1, b.x2, b.y2);
        return;
      }
    }
  }
}
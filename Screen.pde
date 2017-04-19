class Screen {
  PImage bg;
  Button buttonList[];
  Info infoList[];
  
  Screen (PImage bg, Button buttonList[]) {
    this.bg = bg;
    this.buttonList = buttonList;
  }
  
  Screen () {}
  
  void show () {
    background(bg);
    
    // high light if mouse on any button
    Button b;
    for (int i=0; i<buttonList.length; i++) {
      b = buttonList[i]; 
      if (b.containPoint(mouseX, mouseY) && b.enable) {
        noStroke();
        fill(BLUE);
        rect(b.x1, b.y1, b.x2, b.y2);
        return;
      }
    }
    
    // show info
    for (int i=0; i<infoList.length; i++) 
      infoList[i].show();
  }
}

class HighScoreScreen extends Screen {
  HighScoreScreen () {
    bg = loadImage("./Pic/highscore.jpg");
    buttonList = new Button[] {
      new MenuButton(750, 475, 790, 512)
    };
    
    // load data from file
    
    infoList = new Info [] {
      // a lot info here
    };
  }
}

class ChangeUserScreen extends Screen {
  int status = 0;  // 0: user name, 1: password
  
  ChangeUserScreen () {
    bg = loadImage("./Pic/highscore.jpg");
    buttonList = new Button[] {
      new MenuButton(750, 475, 790, 512)
    };
    
    // load data from file
    
    infoList = new Info [] {
      // lots
    };
  }
}
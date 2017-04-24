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
    if (infoList != null)
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
      new MenuButton(0, 0, 100, 100)
    };
    
    // load data from file
    String data [] = loadStrings("./Player/player.txt");
    infoList = new Info [data.length + 2];  
    
    // info[0]: username, info[1]: password
    infoList[0] = new Info("", width/2, 600, BOLD_RED, fontSmall);
    infoList[1] = new Info("", width/2, 650, BOLD_RED, fontSmall);
    infoList[1].hiden = true;
    
    // all user names
    for (int i=0; i<10; i++) {
      infoList[i+2] = new Info(str(i) + ". " + data[i], width/3, 200 + i * 50, BOLD_RED, fontSmall);
    }
  }
}
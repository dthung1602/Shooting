class Screen {
  PImage bg;
  Button buttonList[];
  Info infoList[];
  TimeInfo info = new TimeInfo("", 50, height-50, color(255,0,0), fontSmall, 0);
  
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
        break;
      }
    }
    
    // show info
    if (infoList != null)
      for (int i=0; i<infoList.length; i++) 
        infoList[i].show();
        
    // show time info
    info.show();
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


class ChangePlayerScreen extends Screen {
  int status = 0;  // 0: user name, 1: password
  
  ChangePlayerScreen () {
    bg = loadImage("./Pic/login.png");
    buttonList = new Button[] {
      new MenuButton(157, 25, 235, 100),
      //>> new LoginButton(455, 615, 725, 675),
    };
    
    // load data from file
    String data [] = loadStrings("./Player/player.txt");
    infoList = new Info [data.length + 2];  
    
    // info[0]: username, info[1]: password
    infoList[0] = new Info("", width/2, 100, BOLD_RED, fontMedium);
    infoList[1] = new Info("", width/2, 150, BOLD_RED, fontMedium);
    infoList[1].hiden = true;
    
    // all user names
    for (int i=0; i<data.length; i++) {
      infoList[i+2] = new Info(str(i) + ". " + data[i], width/3, 200 + i * 50, BOLD_RED, fontSmall);
    }
  }
}
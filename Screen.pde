class Screen {
  PImage bg;
  Button buttonList[];
  Info infoList[];
  TimeInfo info = new TimeInfo("", 50, height-50, color(255,0,0), fontSmall, 0);
  int status = 0;
  
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
    
    // >>>show other components
    if (screen == settingScreen) {
      if (soundEnable) 
        image(tickPic, 275, 315);
      if (musicEnable)
        image(tickPic, 275, 385);
    }
  }
}


/*class HighScoreScreen extends Screen {
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
}*/


class ChangePlayerScreen extends Screen {  
  ChangePlayerScreen () {
    bg = loadImage("./Pic/login.png");
    buttonList = new Button[] {
      new DataButton(157, 25, 235, 100),
      new LoginButton(455, 615, 725, 675),
      new TextFieldButton(365, 330, 1000, 382, 0),
      new TextFieldButton(365, 425, 1000, 475, 1),
    };
    
    // load data from file
    String data [] = loadStrings("./Player/player.txt");
    infoList = new Info [data.length + 2];  
    
    // info[0]: username, info[1]: password
    infoList[0] = new Info("", 375, 370, BOLD_RED, fontMedium);
    infoList[1] = new Info("", 375, 465, BOLD_RED, fontMedium);
    infoList[1].hiden = true;
    
    // all user names
    for (int i=0; i<data.length; i++) {
      infoList[i+2] = new Info(data[i], 200 + 210 * (i / 3), 150 + (i % 3) * 50, BOLD_RED, fontMedium);
    }
  }
  
  void show () {
    super.show();
    println(status);
  }
}


class NewPlayerScreen extends Screen {  
  NewPlayerScreen () {
    bg = loadImage("./Pic/new_player.png");
    buttonList = new Button [] {
      new DataButton(155, 25, 235, 100),
      new CreateNewUserButton(460, 615, 725, 680),
      new TextFieldButton(205, 300, 840, 350, 0),
      new TextFieldButton(205, 455, 840, 505, 1),
      new TextFieldButton(205, 525, 840, 575, 2),
    };
    
    infoList = new Info [3];
    
    infoList[0] = new Info("", 220, 332, BOLD_RED, fontMedium);
    infoList[1] = new Info("", 220, 488, BOLD_RED, fontMedium);
    infoList[2] = new Info("", 220, 558, BOLD_RED, fontMedium);
    infoList[1].hiden = true;
    infoList[2].hiden = true;
  }
}

  
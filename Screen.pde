class Screen {
  PImage bg;
  Button buttonList[];
  Info infoList[];
  TimeInfo info = new TimeInfo("", 50, height-50, color(255, 0, 0), fontSmall, 0);
  int status = 0;

  Screen (PImage bg, Button buttonList[]) {
    this.bg = bg;
    this.buttonList = buttonList;
  }

  Screen (PImage bg, Button buttonList[], Info infoList[]) {
    this.bg = bg;
    this.buttonList = buttonList;
    this.infoList = infoList;
  }

  Screen () {
  }

  void changeScreen(Screen newScreen) {
    // check if screen size changes
    if (screen.bg.width != newScreen.bg.width || screen.bg.height != newScreen.bg.height) {
      surface.setResizable(true);
      surface.setSize(newScreen.bg.width, newScreen.bg.height);
      surface.setResizable(false);
    }

    // change screen
    screen = newScreen;
  }

  void show () {
    background(bg);

    // high light if mouse on any button
    Button b;
    for (int i=0; i<buttonList.length; i++) {
      b = buttonList[i]; 
      if (b.containPoint(mouseX, mouseY) && b.enable) {
        b.show();
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
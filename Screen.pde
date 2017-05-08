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

    // delete old message
    screen.info.time = 0;

    // change screen
    screen = newScreen;

    // set count down for play screen
    if (screen == playScreen && enemyCount == 0) 
      playScreen.countDown = (int) frameRate * 3;
      
    // focus on correct input field
    if (screen == changePlayerScreen || screen == newPlayerScreen) {
      for (int i=0; i<screen.infoList.length; i++) {
        screen.infoList[i].input = false;
      }
      screen.infoList[screen.status].input = true;
    }   
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
        if (infoList[i] != null)
          infoList[i].show();

    // show time info
    info.show();

    // >>>show other components
    // tick sound & music in setting screen
    if (screen == settingScreen) {
      if (soundEnable) 
        image(tickPic, 275, 315);
      if (musicEnable)
        image(tickPic, 275, 385);
      return;
    }

    // tick bought weapon in upgrade screens
    for (int i=2; i<4; i++) 
      if (screen == upgradeScreens[i]) {
        for (int j=0; j<4; j++)
          if (j + (i-2)*4 < shooter.weaponList.length  && shooter.weaponList[j + (i-2)*4].enable)
            image(tickPic, 240, 270 + (j) * 87);
        return;
      }

    // cross out lock worlds
    for (int i=0; i<2; i++) 
      if (screen == mapScreens[i]) {
        for (int j=0; j<6; j++)
          if (j + i * 6 > player.maxWorld)
            image(lockWorldPic, 250 + j%3 * 355, 235 + j/3 * 285);
        return;
      }

    // cross out lock rounds
    if (screen == chooseRoundScreen && currentWorld == player.maxWorld) {
      for (int j=0; j<8; j++)
        if (j > player.maxRound)
          image(lockRoundPic, 340 + j%4 * 207, 240 + j/4 * 160);
      if (player.maxRound < 8) 
        image(lockRoundPic, 720, 615);
      return;
    }
  }
}
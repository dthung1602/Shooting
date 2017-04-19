void keyPressed () {
  //-----------------for play screen----------------------
  if (screen == playScreen) {
    // 0-->9: change weapon
    if ('0' <= key && key <= '9' && key-48 < shooter.weaponList.length) {
      shooter.currentWeapon = shooter.weaponList[key-48];
      return;
    }
  
    // other functions
    switch (key) {
      case 'p':
      case 'P': 
        if (screen == pauseScreen)   
          screen = playScreen;
        else 
          screen = pauseScreen;
        break;
      case 'm':
      case 'M':
        if (screen == playScreen)
          screen = menuScreen;
        break;
      case 's':
      case 'S':
        shooter.special();
      default:
        message = "Invalid key!";
        messageTime = 50;
    }
  }
  
  //------------------for choose round screen----------------
  if (screen == choosingRoundScreen) {
    if ('0' > key || '9' < key)
      screen.infoList[0].message += key;
    if (keyCode == 10) {
      resetRound();
      currentRound = int(screen.infoList[0].message);
      screen.infoList[0].message = "";
      screen = playScreen;
    }
  }
  
  //------------------for change user screen----------------
  if (screen == changeUserScreen) {
    if (changeUserScreen.status == 0) 
    if ('0' > key || '9' < key)
      screen.infoList[0].message += key;
    if (keyCode == 10) {
      resetRound();
      currentRound = int(screen.infoList[0].message);
      screen.infoList[0].message = "";
      screen = playScreen;
    }
  }
}
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
    // enter alnum
    if ('0' <= key && key <= '9' || 'a' <= key && key <= 'z' || 'A' <= key && key <= 'A')
      if (changeUserScreen.status == 0)
        changeUserScreen.infoList[0].message += key;
      else 
        changeUserScreen.infoList[1].message += key;
      
    // enter enter
    if (keyCode == 10) {
      
      // if entering username
      if (changeUserScreen.status == 0) {
        
        // check if username in list
        boolean inList = false;
        for (int i=2; i<changeUserScreen.infoList.length; i++) {
          if (changeUserScreen.infoList[i].message.equals(changeUserScreen.infoList[0].message)) {
            inList = true;
            break;
          }
        }
        
        if (!inList) {
          changeUserScreen.infoList[0].message = "";
        } else {
          changeUserScreen.status = 1;
        }
        
      // if entering pass, check validity
      } else {
        
        // read player's file for pass
        String data [] = loadStrings("./Player/" + changeUserScreen.infoList[0].message + ".txt");
        
        // if wrong pass
        if (hash(changeUserScreen.infoList[1].message) != int(data[0])) {
          changeUserScreen.infoList[1].message = "";
          return;
        }
        
        // pass is correct
        player.loadPLayer();
      }
    }
  }
}
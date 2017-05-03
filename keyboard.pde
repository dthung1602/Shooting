void keyPressed () {
  //-----------------for play screen----------------------
  if (screen == playScreen) {
    // 1-->9: change weapon
    if ('1' <= key && key <= '9' && key-49 < shooter.weaponList.length && shooter.weaponList[key-49].enable) {
      shooter.currentWeapon = shooter.weaponList[key-49];
      return;
    }
  
    // other functions
    switch (key) {
      case 'p':
      case 'P': 
        if (screen == pauseScreen) {
          screen = playScreen;
        } else { 
          screen = pauseScreen;
        }
        surface.setSize(screen.bg.width, screen.bg.height);
        break;
      case 'm':
      case 'M':
        if (screen == playScreen) {
          screen = menuScreen;
          surface.setSize(screen.bg.width, screen.bg.height);
        }
        break;
      case 's':
      case 'S':
        shooter.specialAbility();
      default:
        screen.info.message = "Invalid key!";
        screen.info.time = 50;
    }
  }
  
  /*
  //------------------for choose round screen----------------
  if (screen == choosingRoundScreen) {
    // enter number
    if ('0' > key || '9' < key)
      screen.infoList[0].message += key;
      
    // enter enter
    if (keyCode == 10) {
      resetRound();
      currentRound = int(screen.infoList[0].message);
      screen.infoList[0].message = "";
      screen = playScreen;
      surface.setSize(screen.bg.width, screen.bg.height);
    }
    
    // enter back space
    if (keyCode == 8) {
      String s = screen.infoList[0].message;
      if (s.length() == 0) // prevent over del
        return;
      screen.infoList[0].message = s.substring(0, s.length()-1);
    }
  }
  */
  
  //------------------for change user screen----------------
  if (screen == changePlayerScreen) {
    // enter alnum
    if ('0' <= key && key <= '9' || 'a' <= key && key <= 'z' || 'A' <= key && key <= 'A')
        changePlayerScreen.infoList[changePlayerScreen.status].message += key;
    
    // enter back space
    if (keyCode == 8) {
      String s = changePlayerScreen.infoList[changePlayerScreen.status].message;
      if (s.length() == 0) // prevent over del
        return;
      changePlayerScreen.infoList[changePlayerScreen.status].message = s.substring(0, s.length()-1);
    }
      
    // enter enter
    if (keyCode == 10) {
      
      // if entering username, change to entering pass
      if (changePlayerScreen.status == 0) {
        changePlayerScreen.status = 1;
        
      // if entering pass, check validity
      } else {
        login();
      }
    }
  }
}
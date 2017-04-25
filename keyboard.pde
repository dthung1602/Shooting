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
        shooter.specialAbility();
      default:
        screen.info.message = "Invalid key!";
        screen.info.time = 50;
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
  if (screen == changePlayerScreen) {
    // enter alnum
    if ('0' <= key && key <= '9' || 'a' <= key && key <= 'z' || 'A' <= key && key <= 'A')
        changePlayerScreen.infoList[changePlayerScreen.status].message += key;
    
    // enter back space
    if (keyCode == 8) {
      String s = changePlayerScreen.infoList[changePlayerScreen.status].message;
      changePlayerScreen.infoList[changePlayerScreen.status].message = s.substring(0, s.length()-1);
    }
      
    // enter enter
    if (keyCode == 10) {
      
      // if entering username, change to entering pass
      if (changePlayerScreen.status == 0) {
        changePlayerScreen.status = 1;
        
      // if entering pass, check validity
      } else {
        
        // check if username in list
        boolean inList = false;
        for (int i=2; i<changePlayerScreen.infoList.length; i++) {
          if (split(changePlayerScreen.infoList[i].message, " ")[1].equals(changePlayerScreen.infoList[0].message)) {
            inList = true;
            break;
          }
        }
        
        // if not in list of existing users
        if (!inList) {
          changePlayerScreen.infoList[0].message = "";
          changePlayerScreen.infoList[1].message = "";
          changePlayerScreen.status = 0;
          screen.info.message = "Invalid username!";
          screen.info.time = 75;
          return;
        }
        
        // read player's file for pass
        String data [] = loadStrings("./Player/" + changePlayerScreen.infoList[0].message + ".txt");
        
        // if wrong pass
        if (hash(changePlayerScreen.infoList[1].message) != int(data[0])) {
          changePlayerScreen.infoList[1].message = "";
          screen.info.message = "Invalid password!";
          screen.info.time = 75;
          return;
        }
        
        // pass is correct
        screen = menuScreen;
        menuScreen.info =  new TimeInfo ("Welcome, " + changePlayerScreen.infoList[0].message + "!", 500, 50, BOLD_RED, fontSmall, -1);
        //>>>player.loadPlayer();
      }
    }
  }
}
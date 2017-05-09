void keyPressed () {
  //-----------------for play screen----------------------
  if (screen == playScreen) {
    // 1-->9: change weapon
    if ('1' <= key && key <= '9' && key-49 < shooter.weaponList.length && shooter.weaponList[key-49].enable) {
      shooter.currentWeapon = shooter.weaponList[key-49];
      updateBars();
      return;
    }

    // other functions
    switch (key) {
    case 'q':
    case 'Q':
      shooter.currentObj = newObjList[0].clone();
      return;
    case 'w':
    case 'W':
      shooter.currentObj = newObjList[1].clone();
      return;
    case 'e':
    case 'E':
      shooter.currentObj = newObjList[2].clone();
      return;
    case 'r':
    case 'R':
      shooter.currentObj = newObjList[3].clone();
      return;

    case 'p':
    case 'P': 
      screen.changeScreen(pauseScreen);
      return;
    case 'm':
    case 'M':
      screen.changeScreen(leaveGameScreen);
      return;
    case 's':
    case 'S':
      shooter.specialAbility();
      return;
    default:
      screen.info.message = "Invalid key!";
      screen.info.time = 50;
      return;
    }
  }

  //------------------for pause screen-----------------------
  if (screen == pauseScreen) {
    switch (key) {
    case 'p':
    case 'P': 
      screen.changeScreen(playScreen);
      return;
    case 'm':
    case 'M':
      screen.changeScreen(menuScreen);
      return;
    }
  }



  //------------------for change player screen----------------
  if (screen == changePlayerScreen) {
    // enter alnum
    if ('0' <= key && key <= '9' || 'a' <= key && key <= 'z' || 'A' <= key && key <= 'Z')
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

      // if entering playername, change to entering pass
      if (changePlayerScreen.status == 0) {
        // choose the correct input field
        changePlayerScreen.infoList[0].input = false;
        changePlayerScreen.status = 1;
        changePlayerScreen.infoList[1].input = true;

        // if entering pass, check validity
      } else {
        player.login();
      }
    }
  }

  //------------------for new player screen----------------
  if (screen == newPlayerScreen) {
    // enter alnum
    if ('0' <= key && key <= '9' || 'a' <= key && key <= 'z' || 'A' <= key && key <= 'Z')
      newPlayerScreen.infoList[newPlayerScreen.status].message += key;

    // enter back space
    if (keyCode == 8) {
      String s = newPlayerScreen.infoList[newPlayerScreen.status].message;
      if (s.length() == 0) // prevent over del
        return;
      newPlayerScreen.infoList[newPlayerScreen.status].message = s.substring(0, s.length()-1);
    }

    // enter enter
    if (keyCode == 10) {

      // if entering playername or entering pass, change to next field
      if (newPlayerScreen.status < 2) {
        newPlayerScreen.infoList[newPlayerScreen.status].input = false;
        newPlayerScreen.status += 1;
        newPlayerScreen.infoList[newPlayerScreen.status].input = true;

        // if entering re-pass, create new player
      } else {
        player.createPlayer();
      }
    }
  }
}
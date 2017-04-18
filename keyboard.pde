void keyPressed () {
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
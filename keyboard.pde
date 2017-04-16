void keyPressed () {
  // 0-->9: change weapon
  if (Character.isDigit(key) && shooter.weaponList[key].enable) {
    shooter.currentWeapon = shooter.weaponList[key];
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
      pausing = true;
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
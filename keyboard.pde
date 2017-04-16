void keyPressed () {
  // 0-->9: change weapon
  if (Character.isDigit(key)) {
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
      //>>> use special skill
    default:
      message = "Invalid key!";
      messageTime = 50;
  }
}
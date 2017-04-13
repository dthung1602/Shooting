void mousePressed() {
  //check if any button is pressed
  for (int i=0; i<screen.buttonList.length; i++)
    if (screen.buttonList[i].containPoint(mouseX,mouseY) && screen.buttonList[i].enable) {
      screen.buttonList[i].action();
      return;
    }
    
  //drop stuff
  if (shooter.currentStuff != null) {
    stuffList[stuffCount] = shooter.currentStuff;
    stuffCount++;
    shooter.currentStuff = null;
    return;
  }
    
  // shoot
  shooter.currentWeapon.shoot();
}
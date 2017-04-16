void mousePressed() {
  //check if any button is pressed
  for (int i=0; i<screen.buttonList.length; i++)
    if (screen.buttonList[i].containPoint(mouseX,mouseY) && screen.buttonList[i].enable) {
      screen.buttonList[i].action();
      return;
    }
    
  //drop obj
  if (shooter.currentObj != null) {
    objList[objCount] = shooter.currentObj;
    objCount++;
    shooter.currentObj = null;
    return;
  }
    
  // shoot
  if (mouseButton == LEFT)
    shooter.currentWeapon.shoot();
  if (mouseButton == RIGHT)
    shooter.currentWeapon.special();
}
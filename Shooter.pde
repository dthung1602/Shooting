abstract class CanBeAttacked {
  int health;
  CanBeAttacked () {}
}


class Shooter extends CanBeAttacked {
  //basic
  float x = 100; 
  float y = 200;
  int money = 0;
  float angle = 0;
  Weapon currentWeapon;
  Obj currentObj;
  
  //upgrade  
  Weapon weaponList [] = new Weapon [] {};
  boolean aim = false;
  int maxHealth = DEFAULT_HEALTH;
  //>> add new upgrade here
  
  Shooter () {
    super();
  }

  void show () {
    showShooter();
    showAim();
    showWeapon();
  }

  private void showShooter() {
    //>>> draw house, shooter,...
  }

  private void showAim() {
    // skip this function when player does not have aim
    if (!aim) 
      return;
    
    // choose color red
    fill(255, 0, 0);
    stroke(255, 0, 0);
    
    // create a point that move in the same path of the bullet
    float d = dist(x, y, mouseX, mouseY);
    float vx = currentWeapon.speed * (mouseX - x) / d;          // x speed
    float vy = currentWeapon.speed * (mouseY - y) / d;          // y speed
    float tmpx = x + vx;                 // current x pos
    float tmpy = y + vy + GRAVITY * currentWeapon.bullet.weight;       // curretn y pos
    float px = x;                        // prev x pos
    float py = y;                        // prev y pos
    
    // move the point to create the path
    while (tmpy < height - GROUND_HEIGHT && tmpy > 0 && tmpx < width && tmpx > 0) {        // still in screen
      line(px, py, tmpx, tmpy);             // draw a line
      if (currentWeapon instanceof LaserGun)                                      // destroy if using laser gun
        laserDestroy(tmpx, tmpy);
      px = tmpx;                                       // update prev x 
      py = tmpy;                                       // update prev y
      vy += GRAVITY * currentWeapon.bullet.weight;     // effect of gravity
      tmpx += vx;                                      // new curr x
      tmpy += vy;                                      // new curr y
    }
  }
    
  private void showWeapon () {
    angle = - atan2(y-mouseY, mouseX-x);
    translate(x, y);
    rotate(angle);
    image(currentWeapon.img, 0, 0, 100, 75);
    if (currentWeapon instanceof LaserGun)
      image(laserPic, 70, -5, 70, 50);
    rotate(-angle);
    translate(-x, -y);
    currentWeapon.delay -= 1;
  }
  
  void special () {
    if (money < -1)
      return;
    
    money -= 1000;
    for (int i=0; i<10; i++) {
      bulletList[bulletCount] = currentWeapon.newBullet(0, 15);
      bulletList[bulletCount].x = (int) random(50, width-50);
      bulletList[bulletCount].y = (int) random(1, 100);
      bulletCount++;
    }
  }
  
  private void laserDestroy (float tmpx, float tmpy) {
    for (int i=0; i<enemyCount; i++) {
      
      // skip dead enemy
      if (enemyList[i].health > 0) 
        continue;
        
      // check if laser hit any enemy
      //if (dist(tmpx, tmpy, enemyList[i].x, enemyList[i].y) < enemyList[i].size) 
       // enemyList[i].hit(laserBullet);
    }
  }
}
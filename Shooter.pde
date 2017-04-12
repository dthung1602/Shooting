class Shooter {
  //basic
  float x = 100; 
  float y = 200;
  int health = 0;
  int money = 0;
  float angle = 0;
  Weapon currentWeapon;
  Stuff currentStuff;
  
  //upgrade  
  Weapon weaponList [] = new Weapon [] {/*new kind of weapon will be add gradualy*/};
  boolean aim = false;
  int maxHealth = DEFAULT_HEALTH;
  //>> add new upgrade here
  
  Shooter () {}

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
    float tmpy = y + vy + GRAVITY;       // curretn y pos
    float px = x;                        // prev x pos
    float py = y;                        // prev y pos
    
    // move the point to create the path
    while (tmpy < GROUND_HEIGHT && tmpy > 0 && tmpx < width && tmpx > 0) {        // still in screen
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
  }
  
  private void laserDestroy (float tmpx, float tmpy) {
    for (int i=0; i<enemyCount; i++) {
      
      // skip dead enemy
      if (enemyList[i].status == 1) 
        continue;
        
      // check if laser hit any enemy
      if (dist(tmpx, tmpy, enemyList[i].x, enemyList[i].y) < enemyList[i].r) 
        enemyList[i].hit(laserBullet);
    }
  }
}
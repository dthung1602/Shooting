abstract class Weapon {
  Bullet bullet;                 // the kind of bullet weapon creates
  int bulletLeft;                // how many bullet left
  PImage img;
  int defaultDelay;              // how many frames by default before weapon can shoot again
  int delay;                     // how many frames left before weapon can shoot again
  int defaultSpecialDelay;       // how many frames by default before weapon can use special again
  int delaySpecial;              // how many frames left before weapon can use special again
  float speed;                   // how fast the bullet is
  boolean enable = false;        // true: shooter can use; fasle: can't be used
  
  void shoot() {
    // do nothing when delay is not over or out of bullet
    if (delay > 0 || bulletLeft == 0)
      return;
    
    // shoot!
    float d = dist(shooter.x, shooter.y, mouseX, mouseY);
    float vx = speed * (mouseX - shooter.x) / d;          // x speed
    float vy = speed * (mouseY - shooter.y) / d;          // y speed
    bulletList[bulletCount] = newBullet(vx, vy);
    delay = defaultDelay;
    bulletLeft -= 1;
    bulletCount += 1;
  }
  
  Bullet newBullet (float vx, float vy) {
    Weapon wp = shooter.currentWeapon;
    
    if (wp instanceof Hand)
      return new Stone(shooter.x, shooter.y, vx, vy);
    
    if (wp instanceof Arm)
      return new Shuriken(shooter.x, shooter.y, vx, vy);
      
    return new Laser(shooter.x, shooter.y, vx, vy);
  }
  
  void special () {
    // do nothing when delay is not over
    if (delaySpecial > 0)
      return;
      
    delaySpecial = defaultSpecialDelay;
    for (int i=0; i<enemyCount; i++) {
      // skip dead enemy
      if (enemyList[i].health <= 0) 
        continue;
      float d = dist(shooter.x, shooter.y, enemyList[i].x, enemyList[i].y);
      float vx = speed * (enemyList[i].x - shooter.x) / d;          // x speed
      float vy = speed * (enemyList[i].y - shooter.y) / d;          // y speed
      bulletList[bulletCount] = newBullet(vx, vy);
      bulletCount += 1;
    }
  }
}


class Hand extends Weapon{
  Hand () {
    bullet = new Stone(0, 0, 0, 0);
    defaultDelay = 25;
    defaultSpecialDelay = 500;
    img = loadImage("./Pic/laser_gun.png");
    speed = 15;
    bulletLeft = -1;
    enable = true;
  }    
}


class Arm extends Weapon{
  Arm () {
    bullet = new Laser (0, 0, 0, 0);
    defaultDelay = 5000;
    img = loadImage("./Pic/laser_gun.png");
    speed = 20;
    bulletLeft = -1;
  }  
}


class LaserGun extends Weapon {
  LaserGun () {
    bullet = new Laser (0, 0, 0, 0);
    defaultDelay = 5000;
    img = loadImage("./Pic/laser_gun.png");
    speed = 20;
    bulletLeft = -1;
  }
}
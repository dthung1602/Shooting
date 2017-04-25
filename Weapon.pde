abstract class Weapon {
  Bullet bullet;                 // the kind of bullet weapon creates
  int bulletLeft;                // how many bullet left
  PImage img;                    // image
  int defaultDelay;              // how many frames by default before weapon can shoot again
  int delay;                     // how many frames left before weapon can shoot again
  int defaultSpecialDelay;       // how many frames by default before weapon can use special again
  int delaySpecial;              // how many frames left before weapon can use special again
  float speed;                   // how fast the bullet is
  boolean enable;                // can shooter use it or not
  int specialAbilityPrice;       // how much special ability using this weapon cost
  int price;                     // how much this weapon cost
  
  void shoot() {
    // do nothing when delay is not over or out of bullet
    if (delay * shooter.uWeaponDelay > 0 || bulletLeft == 0)
      return;
    
    // shoot!
    float d = dist(shooter.x, shooter.y, mouseX, mouseY);
    float vx = shooter.uWeaponSpeed * speed * (mouseX - shooter.x) / d;          // x speed
    float vy = shooter.uWeaponSpeed * speed * (mouseY - shooter.y) / d;          // y speed
    bulletList[bulletCount] = newBullet(vx, vy);
    delay = defaultDelay;
    bulletLeft -= 1;
    bulletCount += 1;
  }
  
  Bullet newBullet (float vx, float vy) {
    Weapon wp = shooter.currentWeapon;
    
    if (wp instanceof HandStone)
      return new Stone(shooter.x, shooter.y, vx, vy);
    
    if (wp instanceof HandShuriken)
      return new Shuriken(shooter.x, shooter.y, vx, vy);
      
    if (wp instanceof HandGrenade)
      return new Grenade(shooter.x, shooter.y, vx, vy);
      
    if (wp instanceof Bow)
      return new Arrow(shooter.x, shooter.y, vx, vy);
      
    if (wp instanceof FreezeGun)
      return new Ice(shooter.x, shooter.y, vx, vy);
      
    return new Grenade(shooter.x, shooter.y, vx, vy);
  }
  
  void special () {
    // do nothing when delay is not over
    if (delaySpecial * shooter.uSpecialWeaponDelay != 0)
      return;
      
    delaySpecial = defaultSpecialDelay;
    for (int i=0; i<enemyCount; i++) {
      // skip dead enemy
      if (enemyList[i].health <= 0) 
        continue;
      
      // create one bullet for each enemy
      float d = dist(shooter.x, shooter.y, enemyList[i].x, enemyList[i].y);
      float vx = shooter.uWeaponSpeed * speed * 2 * (enemyList[i].x - shooter.x) / d;          // x speed
      float vy = shooter.uWeaponSpeed * speed * 2 * (enemyList[i].y - shooter.y) / d;          // y speed
      bulletList[bulletCount] = newBullet(vx, vy);
      bulletCount += 1;
    }
  }
}


class HandStone extends Weapon {
  HandStone () {
    bullet = new Stone(0, 0, 0, 0);
    defaultDelay = 25;
    defaultSpecialDelay = 250;
    img = handPic;  
    speed = 20;
    bulletLeft = -1;
    specialAbilityPrice = 300; 
    price = 0;
  }    
}


class HandGrenade extends Weapon {
  HandGrenade () {
    bullet = new Grenade (0, 0, 0, 0); 
    defaultDelay = 25;
    defaultSpecialDelay = -1;
    img = handPic;  
    speed = 15;
    bulletLeft = 5;
    specialAbilityPrice = 900; 
    price = 750;
  }
}


class HandShuriken extends Weapon{
  HandShuriken () {
    bullet = new Shuriken(0, 0, 0, 0);
    defaultDelay = 10;
    defaultSpecialDelay = 500;
    img = handPic;
    speed = 20;
    bulletLeft = -1;
    specialAbilityPrice = 300; 
    price = 400;
  }  
}


class Bow extends Weapon {
  Bow () {
    bullet = new Arrow(0, 0, 0, 0);
    defaultDelay = 10;
    defaultSpecialDelay = 500;
    img = bowPic;
    speed = 25;
    bulletLeft = -1;
    specialAbilityPrice = 400; 
    price = 600;
  }  
}


class FreezeGun extends Weapon {
  FreezeGun () {
    bullet = new Ice(0, 0, 0, 0);
    defaultDelay = 10;
    defaultSpecialDelay = 500;
    img = freezeGunPic;
    speed = 25;
    bulletLeft = 20;
    specialAbilityPrice = 350; 
    price = 650;
  }  
}


class LaserGun extends Weapon {
  int blNum = 5;
  
  LaserGun () {
    bullet = new Laser(0, 0, 0, 0);
    defaultDelay = 5;
    defaultSpecialDelay = 500;
    img = laserGunPic;
    speed = 30;
    bulletLeft = -1;
    specialAbilityPrice = 1000; 
    price = 900;
  }
  
  void shoot() {
    // do nothing when delay is not over or out of bullet
    if (delay * shooter.uWeaponDelay > 0 || bulletLeft == 0)
      return;
    
    // shoot!
    float d = dist(shooter.x, shooter.y, mouseX, mouseY);
    float vx = shooter.uWeaponSpeed * speed * (mouseX - shooter.x) / d;          // x speed
    float vy = shooter.uWeaponSpeed * speed * (mouseY - shooter.y) / d;          // y speed
    for (int i=0; i<blNum; i++) {
      bulletList[bulletCount + i] = newBullet(vx, vy);
      bulletList[bulletCount + i].x += vx * i * 5;
      bulletList[bulletCount + i].y += vy * i * 5;
    }
    delay = defaultDelay;
    bulletLeft -= blNum;
    bulletCount += blNum;
  }
}
abstract class Weapon {
  // basic
  String name;
  String explaination; 
  boolean enable;                // can shooter use it or not
  
  // display
  PImage img;                    // image
  
  // bullets
  Bullet bullet;                 // the kind of bullet weapon creates
  int bulletLeft;                // how many bullet left
  int bulletNum = 1;                 // number of buttlet per shot
  float bulletSpeed;                   // how fast the bullet is
  
  // delay
  int defaultDelay;              // how many frames by default before weapon can shoot again
  int delay;                     // how many frames left before weapon can shoot again
  int defaultSpecialDelay;       // how many frames by default before weapon can use special again
  int delaySpecial;              // how many frames left before weapon can use special again
  
  // price
  int specialAbilityPrice;       // how much special ability using this weapon cost
  int price;
  
  void shoot() {
    //------------- do nothing when delay is not over----------------
    if (delay > 0 )
      return;
      
    //--------------warn if out of bullets--------------------------
    if (bulletLeft > 0 && bulletLeft < bulletNum) {
      screen.info.message = "Out of bullet!";
      screen.info.time = MESSAGE_TIME_SHORT;
      return;
    }
    
    // ------------------------shoot!--------------------------------
    // calculate vx, vy for bullet(s)
    float d = dist(shooter.x, shooter.y, mouseX, mouseY);
    float vx = shooter.upgradeList[3].value * bulletSpeed * (mouseX - shooter.x) / d;
    float vy = shooter.upgradeList[3].value * bulletSpeed * (mouseY - shooter.y) / d;
    
    // create bullet(s)
    for (int i=0; i<bulletNum; i++) {
      bulletList[round.bulletCount + i] = bullet.clone(vx, vy);
      bulletList[round.bulletCount + i].x += vx * i * 2;
      bulletList[round.bulletCount + i].y += vy * i * 2;
    }
    
    // set delay, calculate bullets number
    delay = (int) (defaultDelay * shooter.upgradeList[2].value);
    if (bulletLeft > 0)
      bulletLeft -= bulletNum;
    round.bulletCount += bulletNum;
  }
  
  void special () {
    // do nothing when delay is not over
    if (delaySpecial > 0)
      return;
      
    delaySpecial = (int) (defaultSpecialDelay * shooter.upgradeList[5].value);
    for (int i=0; i<round.enemyCount; i++) {
      // skip dead enemy
      if (enemyList[i].health <= 0) 
        continue;
      
      // create one bullet for each enemy
      float d = dist(shooter.x, shooter.y, enemyList[i].x, enemyList[i].y);
      float vx = shooter.upgradeList[3].value * bulletSpeed * 2 * (enemyList[i].x - shooter.x) / d;          // x speed
      float vy = shooter.upgradeList[3].value * bulletSpeed * 2 * (enemyList[i].y - shooter.y) / d;          // y speed
      bulletList[round.bulletCount] = bullet.clone(vx, vy);
      round.bulletCount += 1;
    }
  }
}


class HandStone extends Weapon {
  HandStone () {
    name = "Stone";
    explaination = "explaination for stone";
    
    img = handPic;
    
    bullet = new Stone();
    bulletLeft = Integer.MIN_VALUE;
    bulletNum = 1;
    bulletSpeed = 20;
    
    defaultDelay = 25;
    defaultSpecialDelay = 250;
   
    price = 0;
    specialAbilityPrice = 25; 
  }    
}


class HandShuriken extends Weapon{
  HandShuriken () {
    name = "Shuriken";
    explaination = "explaination for Shuriken";
    
    img = shurikenPic;
    
    bullet = new Shuriken();
    bulletLeft = Integer.MIN_VALUE;
    bulletNum = 1;
    bulletSpeed = 30;
    
    defaultDelay = 20;
    defaultSpecialDelay = 275;
   
    price = 150;
    specialAbilityPrice = 75; 
  }  
}


class Bow extends Weapon {
  Bow () {
    name = "Bow";
    explaination = "explaination for Bow";
    
    img = bowPic;
    
    bullet = new Arrow();
    bulletLeft = Integer.MIN_VALUE;
    bulletNum = 1;
    bulletSpeed = 40;
    
    defaultDelay = 20;
    defaultSpecialDelay = 275;
   
    price = 200;
    specialAbilityPrice = 75; 
  }  
}


class HandGrenade extends Weapon {
  HandGrenade () {
    name = "Grenade";
    explaination = "explaination for Grenade";
    
    img = grenadePic;
    
    bullet = new Grenade();
    bulletLeft = 5;
    bulletNum = 1;
    bulletSpeed = 20;
    
    defaultDelay = 35;
    defaultSpecialDelay = 80;
   
    price = 300;
    specialAbilityPrice = 175; 
  }
}


class FreezeGun extends Weapon {
  FreezeGun () {
    name = "FreezeGun";
    explaination = "explaination for FreezeGun";
    
    img = handPic;
    
    bullet = new Ice();
    bulletLeft = Integer.MIN_VALUE;
    bulletNum = 1;
    bulletSpeed = 20;
    
    defaultDelay = 10;
    defaultSpecialDelay = 150;
   
    price = 400;
    specialAbilityPrice = 100; 
  }  
}


class LaserGun extends Weapon { 
  LaserGun () {
    name = "LaserGun";
    explaination = "explaination for LaserGun";
    
    img = handPic;
    
    bullet = new Laser();
    bulletLeft = Integer.MIN_VALUE;
    bulletNum = 3;
    bulletSpeed = 50;
    
    defaultDelay = 8;
    defaultSpecialDelay = 400;
   
    price = 500;
    specialAbilityPrice = 300; 
  }
}
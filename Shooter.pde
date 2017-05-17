abstract class CanBeAttacked {
  int health;
  CanBeAttacked () {
  }
}


class Shooter extends CanBeAttacked {
  //display info
  float x = 100; 
  float y = 200;
  float angle = 0;
  
  //basic info
  int money;
  int maxRound;    
  int maxWorld;

  Weapon currentWeapon;
  Obj currentObj;

  // weapons
  Weapon weaponList [] = new Weapon [] {
    new HandStone(), 
    new HandShuriken(), 
    new Bow(), 
    new HandGrenade(), 
    new FreezeGun(), 
    new LaserGun(), 
  };

  // upgrades
  // (float value, float increase, float maxLevel, float price, float priceIncrease, int method)
  Upgrade upgradeList [] = new Upgrade [] {
    new Upgrade(0, 1, 1, 100, 1.5, 0),               //0 aim
    new Upgrade(DEFAULT_HEALTH, 50, 5, 100, 1.5, 1), //1 max health 
    new Upgrade(1, -0.15, 6, 100, 1.5, 0),           //2 weapon delay
    new Upgrade(1, 0.1, 5, 100, 1.5, 0),             //3 weapon speed
    new Upgrade(1, 0.2, 5, 100, 1.5, 0),             //4 bonus money
    new Upgrade(1, -0.15, 3, 100, 1.5, 0),           //5 special wp delay
    new Upgrade(1, -0.1, 3, 100, 1.5, 0),            //6 how much special ability cost
    new Upgrade(0, 1, 8, 500, 1.5, 0),               //7 bonus damage
    new Upgrade(1, 0.2, 6, 150, 1.5, 0),             //8 explosion radius
    new Upgrade(0, 20, 5, 180, 1.5, 0),              //9 wall extra health
  };
  
  // objs
  Obj objList [] = new Obj [] {
    new Wall(),
    new BigWall(),
    new Barrel(),
    new ToxicBarrel(),
  };
  

  Shooter () {
  }

  void show () {
    showShooter();
    showAim();
    showWeapon();
  }

  void specialAbility () {
    int price = (int) (upgradeList[6].value * currentWeapon.specialAbilityPrice);
    if (money < price)
      return;

    money -= price;
    for (int i=0; i<10; i++) {
      bulletList[round.bulletCount] = (Bullet) currentWeapon.bullet.clone(0, 5 + random(15)); //0, 15);
      bulletList[round.bulletCount].x = (int) random(50, width-50);
      bulletList[round.bulletCount].y = (int) random(1, 100);
      round.bulletCount++;
    }
  }

  private void showShooter() {
    //>>> draw house, shooter,...
  }

  private void showAim() {
    // skip this function when player does not have aim
    if (shooter.upgradeList[0].value == 0) 
      return;

    // choose int red
    fill(255, 0, 0);
    stroke(255, 0, 0);

    // create a point that move in the same path of the bullet
    float d = dist(x, y, mouseX, mouseY);
    float vx = shooter.upgradeList[3].value * currentWeapon.bulletSpeed * (mouseX - x) / d;          // x speed
    float vy = shooter.upgradeList[3].value * currentWeapon.bulletSpeed * (mouseY - y) / d;          // y speed
    float tmpx = x + vx;                                                              // current x pos
    float tmpy = y + vy + GRAVITY * currentWeapon.bullet.weight;                      // curretn y pos
    float px = x;                                                                     // prev x pos
    float py = y;                                                                     // prev y pos

    // move the point to create the path
    while (tmpy < height - GROUND_HEIGHT && tmpy > 0 && tmpx < width && tmpx > 0) {        // still in screen
      line(px, py, tmpx, tmpy);             // draw a line
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
    rotate(-angle);
    translate(-x, -y);
    if (currentWeapon.delay > 0)
      currentWeapon.delay--;
    if (currentWeapon.delaySpecial > 0)
      currentWeapon.delaySpecial--;
  }
}
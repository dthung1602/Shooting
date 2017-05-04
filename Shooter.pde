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
  boolean aim = false;
  Weapon weaponList [] = new Weapon [] {
    new HandStone(),
    new HandShuriken(),
    new Bow(),
    new HandGrenade(),
    new FreezeGun(),
    new LaserGun(),
  };
  //(float value, float defaultValue, float increase, float max, float min, float price, float priceIncrease, int method)
  Upgrade upgradeList [] = new Upgrade [] {
    new Upgrade(DEFAULT_HEALTH, DEFAULT_HEALTH, 50, 1000, DEFAULT_HEALTH, 100, 1.5, 1),  //max health
    new Upgrade(1, 1, -0.15, 1, 0.1, 100, 1.5, 0),                                       //weapon delay
    new Upgrade(1, 1, 0.2, 3, 1, 100, 1.5, 0),                                           //max health
  };
  float maxHealth = DEFAULT_HEALTH;
  float uWeaponDelay = 1;        // * how long before weapon can shoot again
  float uWeaponSpeed = 1;        // * how fast bullet is
  float uBonusMoney  = 1;        // * how much more money / an enemy
  float uSpecialWeaponDelay = 1; // * how long before weapon can use it special ability
  float uSpecialPrice = 1;       // * how much special ability cost 
  float uBonusDamage = 0;        // + how much extra damage bullet cause
  float uExplodeRadius = 1;      // * how large explosion radius is
  int uWallExtraHealth = 0;      // + wall extra health
  
  Shooter () {}

  void show () {
    showShooter();
    showAim();
    showWeapon();
  }

  void specialAbility () {
    if (money < uSpecialPrice)
      return;
    
    money -= uSpecialPrice * currentWeapon.specialAbilityPrice;
    for (int i=0; i<10; i++) {
      bulletList[bulletCount] = currentWeapon.newBullet(0, 15);
      bulletList[bulletCount].x = (int) random(50, width-50);
      bulletList[bulletCount].y = (int) random(1, 100);
      bulletCount++;
    }
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
    float vx = shooter.uWeaponSpeed * currentWeapon.speed * (mouseX - x) / d;          // x speed
    float vy = shooter.uWeaponSpeed * currentWeapon.speed * (mouseY - y) / d;          // y speed
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
    currentWeapon.delay -= 1;
  }
  
  class Upgrade {
    float value;              // hold value of upgrade
    float defaultValue;       // hold defaut value of upgrade
    float increase;           // how much value can increase
    float max = 5;
    float min = 0;
    float price;
    float priceIncrease;
    int method;               // 0 = +;  1 = *
    
    Upgrade (float value, float defaultValue, float increase, float max, float min, float price, float priceIncrease, int method) {
      this.value = value;
      this.defaultValue = defaultValue;
      this.increase = increase;
      this.max = max;
      this.min = min;
      this.price = price;
      this.priceIncrease = priceIncrease;
      this.method = method;
    }
    
    void upgrade() {
      // check if player has enough money
      if (shooter.money < price) {
        screen.info.message = "Not enough money!";
        screen.info.time = 75;
        return;
      }
      
      // check if player reach max value
      float tmp = (method == 1) ? value * increase : value + increase;
      if (tmp > max) {
        screen.info.message = "Max upgrade!";
        screen.info.time = 75;
        return; 
      }
      
      // upgrade
      shooter.money -= price;
      price *= priceIncrease;
      value = tmp;
    }
    
    void downgrade () {
      // check if player reach min value
      float tmp = (method == 1) ? value / increase : value - increase;
      if (tmp < min) {
        screen.info.message = "Min downgrade!!";
        screen.info.time = 75;
        return; 
      }
      
      // downgrade
      shooter.money += price * SELL_PERCENT;
      price /= priceIncrease;
      value = tmp;
    }
  }
}
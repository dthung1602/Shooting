abstract class Bullet  implements Cloneable {
  // basic
  int status = 0;          // 0 = in game; 1 = out of game
  int damage;
  int hitRadius;           // how close bullet to enemy to be considered as hit
  int price;
  PImage img;
  
  // movement
  float x, y;
  float vx,vy;
  float weight;            // how much gravity affects bullet. 0 = no effect;
  
  Bullet () {
  }
  
  void show () {    
    //touch sides, skip out of range bullets
    if (x<0 || x>width || y<0  || y > height - GROUND_HEIGHT) {
      status = 1;
      return;
    }
    
    // move
    x += vx;
    y += vy;    
    vy += GRAVITY * weight;     // effect of gravity
    
    // check if bullet hit any obj
    for (int i=0; i<round.objCount; i++) {
      if (objList[i].health > 0 && objList[i].containPoint(x, y)) {
        status = 1;
        objList[i].action();
        action();
        break;
      }
    }
    
    // check if bullet hit any enemy
    for (int i=0; i<round.enemyCount; i++) {
      if (enemyList[i].health > 0 && touch(enemyList[i])) {
        status = 1;
        enemyList[i].hit(this);
        action();
        break;
      }
    }
    
    // draw
    image(img, x, y, 20, 20);
  }   
  
  boolean touch (Enemy e) {
    if (dist(x, y, e.x, e.y) < e.size + hitRadius)
      return true;
    return false;
  }
  
  Bullet clone(float vx, float vy) {
    try {
      Bullet bl =  (Bullet) super.clone();
      bl.vx = vx;
      bl.vy = vy;
      bl.x = shooter.x;      // bullet starts at weapon's pos
      bl.y = shooter.y;
      return bl;
    } 
    catch (CloneNotSupportedException e) {
      return null;
    }
  }
  
  void action () {}
}


abstract class ExplodesiveBullet extends Bullet {
  int explosiveRadius;
  
  ExplodesiveBullet() {
  }
  
  void action () {
    // cause damage to surounding enemies
    for (int i=0; i<round.enemyCount; i++) {
      if (enemyList[i].health > 0 && dist(enemyList[i].x, enemyList[i].y, x, y) < explosiveRadius * shooter.upgradeList[8].value)
        enemyList[i].hit(this);
    }
    
    // triggers others obj to explode
    // TODO
    
    // add explosive effect
    effectList[round.effectCount] = new ExplosionEffect(x, y);
    round.effectCount++;
  }
}


class Stone extends Bullet {
  Stone () {
    damage = 1;
    hitRadius = 5;
    price = 0;
    weight = 1;
    img = stonePic;    
  }
}


class Shuriken extends Bullet {
  Shuriken () {
    damage = 2;
    hitRadius = 5;
    price = 0;
    weight = 0;
    img = shurikenPic;
  }
}


class Arrow extends Bullet {
  Arrow () {
    damage = 3;
    hitRadius = 5;
    price = 0;
    weight = 0;
    img = arrowPic;
  }
}


class Grenade extends ExplodesiveBullet {
  Grenade () {
    damage = 1;
    hitRadius = 5;
    price = 50;
    weight = 1.2;
    img = grenadePic;
    explosiveRadius = 50;
  }
}


class Ice extends Bullet {
  // TODO freeze
  Ice () {
    damage = 1;
    hitRadius = 5;
    price = 0;
    weight = 0;
    img = icePic;
  }
}


class Laser extends Bullet {
  Laser () {
    damage = 5;
    hitRadius = 5;
    price = 0;
    weight = 0;
    img = laserPic;
  }
}
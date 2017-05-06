abstract class Bullet {
  float x, y;
  float vx,vy;
  int status = 0;          // 0 = in game; 1 = out of game
  int damage;
  int hitRadius;
  float weight;            // how much gravity affects bullet. 0 = no effect;
  PImage img;
  int price = 0;
  
  Bullet (float x, float y, float vx, float vy) {
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
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
    for (int i=0; i<objCount; i++) {
      if (objList[i].health > 0 && objList[i].containPoint(x, y)) {
        status = 1;
        objList[i].action();
        action();
        break;
      }
    }
    
    // check if bullet hit any enemy
    for (int i=0; i<enemyCount; i++) {
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
  
  void action () {}
}

class Stone extends Bullet {
  Stone (float x, float y, float vx, float vy) {
    super(x, y, vx, vy);
    damage = 1;
    img = stonePic;
    weight = 1;
    hitRadius = 5;
  }
}


class Grenade extends Bullet {
  int explosiveRadius = 100;
  
  Grenade (float x, float y, float vx, float vy) {
    super(x, y, vx, vy);
    damage = 1;
    img = grenadePic;
    weight = 1;
    hitRadius = 5;
    price = 50;
  }
  
  void action () {
    // explode
    for (int i=0; i<enemyCount; i++) {
      if (enemyList[i].health > 0 && dist(enemyList[i].x, enemyList[i].y, x, y) < explosiveRadius * shooter.upgradeList[8].value)
        enemyList[i].hit(this);
    }
    
    // add explosive effect
    effectList[effectCount] = new ExplosionEffect(x, y);
    effectCount++;
  }
}


class Shuriken extends Bullet {
  Shuriken (float x, float y, float vx, float vy) {
    super(x, y, vx, vy);
    damage = 2;
    img = shurikenPic;
    weight = 0;
  }
}



class Arrow extends Bullet {
  Arrow (float x, float y, float vx, float vy) {
    super(x, y, vx, vy);
    damage = 2;
    img = arrowPic;
    weight = 0;
  }
}


class Ice extends Bullet {
  Ice (float x, float y, float vx, float vy) {
    super(x, y, vx, vy);
    damage = 2;
    img = icePic;
    weight = 0;
  }
}



class Laser extends Bullet {
  Laser (float x, float y, float vx, float vy) {
    super(x, y, vx, vy);
    damage = 500;
    img = laserPic;
    weight = 0;
    price = 5;
  }
}
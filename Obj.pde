abstract class Obj extends CanBeAttacked implements java.lang.Cloneable {
  int x, y;
  int vx = 0, vy = 0;
  PImage img;
  int size;
  boolean walkthrough;
  int price;
  boolean enable;

  Obj () {
  }

  void show () {
    x += vx;
    y += vy;    
    if (y < height - GROUND_HEIGHT)
      vy += GRAVITY;                      // effect of gravity
    image(img, x, y);
  }

  boolean containPoint (float xx, float yy) {
    if (x-size/2<=xx && xx<x+size/2 && y-size/2<yy && yy<y+size/2)
      return true;
    return false;
  }

  void action () {
  }
}


abstract class ExplosiveObj extends Obj {
  int damage;
  int explosionRadius;

  void action () {
    health = 0;
    effectList[effectCount] = new ExplosionEffect(x, y);
    effectCount++;
    for (int i=0; i<enemyCount; i++) {
      if (enemyList[i].health > 0 && touch(enemyList[i])) {
        enemyList[i].hit(this);
      }
    }
  }

  private boolean touch (Enemy e) {
    if (dist(e.x, e.y, x, y) < explosionRadius * shooter.upgradeList[8].value)
      return true;
    return false;
  }
}


class Wall extends Obj {
  Wall () {
    health = (int) shooter.upgradeList[9].value + 50;
    img = loadImage("./Pic/wall.png");
    size = 100;
    walkthrough = false;
    price = 20;
  }  
}

class BigWall extends Obj {
  BigWall () {
    health = (int) shooter.upgradeList[9].value + 100;
    img = loadImage("./Pic/wall.png");
    size = 150;
    walkthrough = false;
    price = 40;
  }  
}


class Barrel extends ExplosiveObj {
  Barrel () {
    health = 1;
    img = loadImage("./Pic/barrel.png");
    size = 75;
    damage = 1;
    explosionRadius = 100;
    walkthrough = true;
    price = 60;
  }  
}


class ToxicBarrel extends ExplosiveObj {
  ToxicBarrel () {
    health = 1;
    img = loadImage("./Pic/toxicbarrel.png");
    size = 75;
    damage = 2;
    explosionRadius = 100;
    walkthrough = true;
    price = 80;
  }
}
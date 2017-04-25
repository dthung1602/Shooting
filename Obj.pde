abstract class Obj extends CanBeAttacked {
  int x, y;
  int vx = 0, vy = 0;
  PImage img;
  int size;
  boolean walkthrough;
  
  Obj (int x, int y) {
    super();
    this.x = x;
    this.y = y;
  }
    
  void show () {
    x += vx;
    y += vy;    
    if (y < height - GROUND_HEIGHT)
      vy += GRAVITY;                      // effect of gravity
    image(img, x, y, size, size);
  }
  
  boolean containPoint (float xx, float yy) {
    if (x-size/2<=xx && xx<x+size/2 && y-size/2<yy && yy<y+size/2)
      return true;
    return false;
  }
  
  void action () {}
}


abstract class ExplosiveObj extends Obj{
  int damage;
  int explosionRadius;
  ExplosiveObj (int x, int y) {
    super(x, y);
  }
  
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
    if (dist(e.x, e.y, x, y) < explosionRadius * shooter.uExplodeRadius)
      return true;
    return false;
  }
}


class Wall extends Obj {
  Wall (int x, int y) {
    super(x, y);
    health = shooter.uWallExtraHealth + 50;
    img = loadImage("./Pic/wall.png");
    size = 100;
    walkthrough = false;
  }  
}

class BigWall extends Obj {
  BigWall (int x, int y) {
    super(x, y);
    health = shooter.uWallExtraHealth + 100;
    img = loadImage("./Pic/wall.png");
    size = 150;
    walkthrough = false;
  }  
}


class Barrel extends ExplosiveObj {
  Barrel (int x, int y) {
    super(x, y);
    health = 1;
    img = loadImage("./Pic/barrel.png");
    size = 75;
    damage = 1;
    explosionRadius = 100;
    walkthrough = true;
  }  
}


class ToxicBarrel extends ExplosiveObj {
  ToxicBarrel (int x, int y) {
    super(x, y);
    health = 1;
    img = loadImage("./Pic/toxicbarrel.png");
    size = 75;
    damage = 2;
    explosionRadius = 100;
    walkthrough = true;
  }  
}
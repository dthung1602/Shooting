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
    image(img, x, y, 100, 100);
  }
  
  boolean containPoint (float xx, float yy) {
    if (x-size/2<=xx && xx<x+size/2 && y-size/2<yy && yy<y+size/2)
      return true;
    return false;
  }
  
  void action () {}
}

// tmp class

abstract class AttackableObj extends Obj{
  int damage;
  AttackableObj (int x, int y) {
    super(x, y);
  }
}

class ExWall extends AttackableObj {
  ExWall (int x, int y) {
    super(x, y);
    health = 50;
    img = loadImage("./Pic/wall.png");
    size = 100;
    walkthrough = false;
    damage = 1;
  }
  
  void action () {
    health = 0;
    effectList[effectCount] = new ExplosionEffect(x, y);
    effectCount++;
    for (int i=0; i<enemyCount; i++) {
      if (enemyList[i].health > 0 && containPoint(enemyList[i].x, enemyList[i].y)) {
        enemyList[i].hit(this);
      }
    }
  }
}
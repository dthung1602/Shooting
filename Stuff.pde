abstract class Stuff extends CanBeAttacked {
  int x, y;
  int vx = 0, vy = 0;
  PImage img;
  int health;
  int size;
  boolean walkthrough;
  
  Stuff (int x, int y) {
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

abstract class AttackableStuff extends Stuff{
  int damage;
  AttackableStuff (int x, int y) {
    super(x, y);
  }
}

class ExWall extends AttackableStuff {
  ExWall (int x, int y) {
    super(x, y);
    health = 5;
    img = loadImage("./Pic/wall.png");
    size = 100;
    walkthrough = false;
    damage = 1;
  }
  
  void action () {
    health = 0;
    for (int i=0; i<enemyCount; i++) {
      if (enemyList[i].health > 0 && containPoint(enemyList[i].x, enemyList[i].y)) {
        enemyList[i].hit(this);
      }
    }
  }
}
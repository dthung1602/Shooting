abstract class Bullet {
  float x, y;
  float vx,vy;
  int status = 0;          // 0 = in game; 1 = out of game
  int damage;              
  float weight;            // how much gravity affects bullet. 0 = no effect;
  PImage img;
  
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
    
    // check if bullet hit any enemy
    for (int i=0; i<enemyCount; i++) {
      if (enemyList[i].health > 0 && touch(enemyList[i])) {
        status = 1;
        enemyList[i].hit(this);
        break;
      }
    }
    
    // check if bullet hit any stuff
    for (int i=0; i<stuffCount; i++) {
      if (stuffList[i].health > 0 && stuffList[i].containPoint(x, y)) {
        stuffList[i].action();
        status = 1;
      }
    }
    
    // draw
    image(img, x, y, 20, 20);
  }   
  
  private boolean touch (Enemy e) {
    if (dist(x, y, e.x, e.y) < e.size)
      return true;
    return false;
  }
}

class Stone extends Bullet {
  Stone (float x, float y, float vx, float vy) {
    super(x, y, vx, vy);
    damage = 1;
    img = stonePic;
    weight = 1;
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

class Laser extends Bullet {
  Laser (float x, float y, float vx, float vy) {
    super(x, y, vx, vy);
    weight = 0;
  }
  void move(){};
}
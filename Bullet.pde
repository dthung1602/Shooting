//-----------------------------------------------------------
//   classes of bullets that are NOT affected by gravity
//-----------------------------------------------------------

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
    if (x<0 || x>width || y<0) {
      status = 1;
      return;
    }
    
    // move
    x += vx;
    y += vy;    
    vy += GRAVITY * weight;     // effect of gravity
    
    // check if bullet hit any enemy
    for (int i=0; i<enemyCount; i++) {
      if (touch(enemyList[i])) {
        status = 1;
        enemyList[i].hit(this);
      }
    }
    
    // draw
    image(img, x, y);
  }   
  
  private boolean touch (Enemy e) {
    if (dist(x, y, e.x, e.y) < e.r)
      return true;
    return false;
  }
}

class Stone extends Bullet {
  Stone (float x, float y, float vx, float vy) {
    super(x, y, vx, vy);
    damage = 1;
    img = stonePic;
    weight = 0.8;
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
    weight = 0.8;
  }
  void move(){};
}
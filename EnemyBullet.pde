abstract class EnemyBullet extends Bullet {
  EnemyBullet () {
  }
  
  void show() {
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
    
    // check if bullet hit shooter
    if (dist(shooter.x, shooter.y, x, y) < 50) {
      status = 1;
      shooter.health -= damage;
      action();
    }
    
    image(img, x, y);
  }
  
  EnemyBullet clone(int x, int y, float vx, float vy) {
    try {
      EnemyBullet bl = (EnemyBullet) super.clone();
      bl.vx = vx;
      bl.vy = vy;
      bl.x = x;
      bl.y = y;
      return bl;
    } 
    catch (CloneNotSupportedException e) {
      return null;
    }
  }
}
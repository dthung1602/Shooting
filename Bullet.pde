class Bullet {
  float x = width/2;
  float y = groundHeight;
  float vx,vy;
  int status = 0;
  
  Bullet (float tmp_vx, float tmp_vy) {
    vx = tmp_vx;
    vy = tmp_vy;
  }
  
  void move () {    
    //touch sides
    if (x<0 || x>width)
      vx *= -0.7;
    if (y<0)
      vy *= -0.7;
    
    // move
    x += vx * saFastBullet;
    y += vy * saFastBullet;
    vy += gravity;
    
    // pop
    for (int i=0; i<ballList.length; i++) {
      if (touch(ballList[i])) {
        if (saFireBullet<0)
          status = 1;
        ballList[i].status = 1;
        ballList[i].action();
        popCount++;
        if (saFireWorkBullet>0)
          saFireWork();
        return;
      }
    } 
    
    //touch ground
    if (y>groundHeight)
      status = 1;      
  }
  
  void show () {
    if (status == 1)
      return;
    rect(x,y,size,size);
  }
  
  boolean touch (Ball b) {
    if (b.status==1)
      return false;
    if (dist(x,y,b.x,b.y)<b.r+size)
      return true;
    return false;
  }
  
  void saFireWork() {
    for (int i=0; i<10; i++) {
      Bullet b = new Bullet (random(-15,15),random(-15,15));
      b.x = x;
      b.y = y;
      bulletList = (Bullet []) append (bulletList, b);
    }
  }
}

class HBullet extends Bullet {
  HBullet (float tmp_vx) {
    super(tmp_vx,0);
    x = width/2;
    y = height*3/4 - 30;
  }
  
  void move () {    
    //touch sides
    if (x<0 || x>width)
      status = 1;
    
    // move
    x += vx * saFastBullet;
    
    // pop
    for (int i=0; i<ballList.length; i++) {
      if (touch(ballList[i])) {
        if (saFireBullet<0)
          status = 1;
        ballList[i].status = 1;
        ballList[i].action();
        popCount++;
        if (saFireWorkBullet>0)
          saFireWork();
        return;
      }
    } 
    
    //touch ground
    if (y>groundHeight)
      status = 1;      
  }
}


class VBullet extends Bullet {
  VBullet (float tmp_vy, float tmp_x, float tmp_y) {
    super(0,tmp_vy);
    x = tmp_x;
    y = tmp_y;
  }
  
  void move () {       
    // move
    y += vy * saFastBullet;
    vy += gravity/2;
    
    // pop
    for (int i=0; i<ballList.length; i++) {
      if (touch(ballList[i])) {
        if (saFireBullet<0)
          status = 1;
        ballList[i].status = 1;
        ballList[i].action();
        popCount++;
        if (saFireWorkBullet>0)
          saFireWork();
        return;
      }
    }
  }
} 
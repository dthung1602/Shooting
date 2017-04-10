class Ball {
  float x,y;
  float vx, vy;
  float r;
  float status = 0;
  int damage = 1;
  color cl;
  
  Ball (float tmp_x, float tmp_y, float tmp_vx, float tmp_vy, float tmp_r) {
    x = tmp_x;
    y = tmp_y;
    vx = tmp_vx;
    vy = tmp_vy;
    r = tmp_r;
    cl = color(0,(int)random(0,100),(int)random(0,100));
  }
  
  void move () {
    //freeze
    if (saFreeze>0)
      return;
    
    //move   
    x += vx;
    y += vy;
    if (y+r<groundHeight)
      vy += gravity;
    
    //check if touch ground
    if (y + r>=groundHeight) {
      vy *= -0.95;
      x += vx;
      y += vy;
    }
    
    //check if touch canon
    if (abs(x-width/2)<c.radius+r) {
      health -= damage;
      status = 1;     
    }
  }
  
  void show () {
    fill(cl);
    ellipse(x,y,r*2,r*2);
  }
  
  void action () {}
}


class DecreaseRateBall extends Ball {
  DecreaseRateBall (float tmp_x, float tmp_y, float tmp_vx, float tmp_vy, float tmp_r) {
    super(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r);
    cl = color(255,255,0);
    info = "Decrease ball rate!";
    infoTime = 100;
    damage = 2;
  }
  
  void action () {
    ballRate += 25;
  }
  
}


class HealthBall extends Ball {
  HealthBall (float tmp_x, float tmp_y, float tmp_vx, float tmp_vy, float tmp_r) {
    super(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r);
    cl = color(255,0,0,100);
    info = "Increase Health!";
    infoTime = 100;
    damage = 3;
  }
  
  void action () {
    health += 10;
  }
}


class ClearBall extends Ball {
  ClearBall (float tmp_x, float tmp_y, float tmp_vx, float tmp_vy, float tmp_r) {
    super(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r);
    cl = color(255,255,255,100);
    info = "Clear Screen!";
    infoTime = 100;
    damage = 4;
  }
  
  void action () {
    saClear = true;
  }
}


class SlowBall extends Ball {
  SlowBall (float tmp_x, float tmp_y, float tmp_vx, float tmp_vy, float tmp_r) {
    super(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r);
    cl = color(0,255,255,100);
    info = "Slow balls down!";
    infoTime = 100;
    damage = 2;
  }
  
  void action () {
    if (maxSpeed==3)
      return;
    maxSpeed-=5;
  } 
}


class ExplosiveBall extends Ball {
  float explosive_r = 500;
  
  ExplosiveBall (float tmp_x, float tmp_y, float tmp_vx, float tmp_vy, float tmp_r) {
    super(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r);
    cl = color(255,137,26,100);
    info = "Explosive Ball!";
    infoTime = 100;
    damage = 6;
  }
  
  void action () {
    for (int i=0; i<ballList.length; i++) 
      if (ballList[i].status==0 && dist(x,y,ballList[i].x,ballList[i].y) < explosive_r) {
          popCount++;
          ballList[i].status = 1;
          ballList[i].action();
      }
  }
}


class AntiGravityBall extends Ball {
  AntiGravityBall (float tmp_x, float tmp_y, float tmp_vx, float tmp_vy, float tmp_r) {
    super(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r);
    cl = color(100,0,150,100);
    info = "Anti-gravity Ball!";
    infoTime = 750;
    damage = 2;
  }
  
  void action () {
    gravity = 0.1;
    saMaxSpeed = maxSpeed;
    if (maxSpeed>2) 
      maxSpeed = 2;
    saAntiGravity = true;
  }
}


class GravityBall extends Ball {
  GravityBall (float tmp_x, float tmp_y, float tmp_vx, float tmp_vy, float tmp_r) {
    super(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r);
    cl = color(100,0,150,100);
    info = "Gravity Ball!";
    infoTime = 750;
    damage = 3;
  }
  
  void action () {
    gravity = 0.95;
    saGravity = true;
  }
}


class PushBackBall extends Ball {
  PushBackBall (float tmp_x, float tmp_y, float tmp_vx, float tmp_vy, float tmp_r) {
    super(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r);
    cl = color(100,0,150,100);
    info = "Push Back Ball!";
    infoTime = 100;
    damage = 3;
  }
  
  void action () {
    for (int i=0; i<ballList.length; i++)
      if (ballList[i].status==0) 
          ballList[i].x -= 500;
  }
}


class LaserBall extends Ball {
  LaserBall (float tmp_x, float tmp_y, float tmp_vx, float tmp_vy, float tmp_r) {
    super(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r);
    cl = color(255,0,0);
    info = "Laser Ball!";
    infoTime = 100;
    damage = 5;
  }
  
  void action () {
    laserOn = 750;
  }
}


class FreezeBall extends Ball {
  FreezeBall (float tmp_x, float tmp_y, float tmp_vx, float tmp_vy, float tmp_r) {
    super(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r);
    cl = color(0,10,150,100);
    info = "Freeze Ball!";
    infoTime = 100;
    damage = 3;
  }
  
  void action () {
    saFreeze = 250;
  }
}


class GiantBulletBall extends Ball {
  GiantBulletBall (float tmp_x, float tmp_y, float tmp_vx, float tmp_vy, float tmp_r) {
    super(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r);
    cl = color(0,10,150,100);
    info = "Giant Bullet Ball!";
    infoTime = 100;
    damage = 4;
  }
  
  void action () {
    saGiantBullet = 500;
    size = 60;
  }
}


class FireBulletBall extends Ball {
  FireBulletBall (float tmp_x, float tmp_y, float tmp_vx, float tmp_vy, float tmp_r) {
    super(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r);
    cl = color(255,150,50,100);
    info = "Fire Bullet Ball!";
    infoTime = 100;
    damage = 5;
  }
  
  void action () {
    saFireBullet = 750;
    size = 20;
    bulletColor = color(255,0,0);
  }
}


class FireWorkBall extends Ball {
  boolean clStatus = true;
  
  FireWorkBall (float tmp_x, float tmp_y, float tmp_vx, float tmp_vy, float tmp_r) {
    super(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r);
    cl = color(255,0,0);
    info = "Fire Work Ball!";
    infoTime = 100;
    damage = 4;
  }
  
  void move () {
    //change color
    if(clStatus)
      cl = color(255,255,0);
    else
      cl = color(255,0,0);
    clStatus = !clStatus;
    
    //freeze
    if (saFreeze>0)
      return;
    
    //move   
    x += vx;
    y += vy;
    if (y+r<groundHeight)
      vy += gravity;
    
    //check if touch ground
    if (y + r>=groundHeight) {
      vy *= -0.95;
      x += vx;
      y += vy;
    }
    
    //check if touch canon
    if (abs(x-width/2)<c.radius+r) {
      health -= damage;
      status = 1;     
    }
  }
  
  void action () {
    saFireWorkBullet = 750;
    bulletColor = color(255,255,0);
  }
}


class FastBulletBall extends Ball {
  FastBulletBall (float tmp_x, float tmp_y, float tmp_vx, float tmp_vy, float tmp_r) {
    super(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r);
    cl = color(0,255,0);
    info = "Fast Bullet Ball!";
    infoTime = 100;
    damage = 2;
  }
  
  void action () {
    saFastBullet = saFastBullet + 0.25;
    bulletColor = color(50,255,50);
  }
}

class BigBall extends Ball {  
  BigBall (float tmp_x, float tmp_y, float tmp_vx, float tmp_vy, float tmp_r) {
    super(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r);
    cl = color(200,30,180);
    info = "Big Ball!";
    infoTime = 100;
    damage = 3;
  }
  
  void action () {
    saBigBall += 1000;
    minSize += 10;
    midSize += 12;
    maxSize += 15;
  }
}

class HorizontaShootBall extends Ball {
  HorizontaShootBall (float tmp_x, float tmp_y, float tmp_vx, float tmp_vy, float tmp_r) {
    super(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r);
    cl = color(130,200,30);
    info = "Upgrade Ball!";
    infoTime = 100;
    damage = 6;
  }
  
  void action () {
    if (!hShoot)
      hShoot = true;
    else
      hshootRate = constrain(hshootRate-25,25,150);
  }
}


class VerticalShootBall extends Ball {
  VerticalShootBall (float tmp_x, float tmp_y, float tmp_vx, float tmp_vy, float tmp_r) {
    super(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r);
    cl = color(30,200,130);
    info = "Upgrade Ball!";
    infoTime = 100;
    damage = 5;
  }
  
  void action () {
    if (!vShoot)
      vShoot = true;
    else 
      vshootRate = constrain(vshootRate-25,25,150);
  }
}
void draw () {
  background(255);
  
  if (checkLose())
    return;
  specialActions();
  printInfo();
  
  createBall();
  moveBalls();
  moveBullets();
  specialShoot();
    
  //draw canon
  c.show();
  
  //draw ground
  fill(GROUND);
  stroke(GROUND);
  rect(width/2,(groundHeight+height)/2,width,height-groundHeight);  
}


void specialActions () {
  //increase ball speed
  if (frameCount%800==0)
    maxSpeed = constrain(maxSpeed+1,2,16);
  
  //decrease ball rate
  if (frameCount%100==0) {
    ballRate -= 3;
    if (ballRate<40)
      ballRate = 40;
  }
  
  //purify arrays every 10 seconds
  if (frameCount%500==0) {
    //purify ball array
    int count = 0;
    for (int i=0; i<ballList.length; i++)
      if (ballList[i].status == 0)
        count++;
    Ball [] tmpbList = new Ball [count];
    count = 0;
    for (int i=0; i<ballList.length; i++)
      if (ballList[i].status == 0) {
        tmpbList[count] = ballList[i];
        count++;
      }
    ballList = tmpbList;
    
    //purify bullet array
    count = 0;
    for (int i=0; i<bulletList.length; i++)
      if (bulletList[i].status == 0)
        count++;
    Bullet [] tmpList = new Bullet [count];
    count = 0;
    for (int i=0; i<bulletList.length; i++)
      if (bulletList[i].status == 0) {
        tmpList[count] = bulletList[i];
        count++;
      }
    bulletList = tmpList;
  }
  
  //clear screen
  if (saClear) {
    ballList = new Ball [0];
    bulletList = new Bullet [0];
    saClear = false;
  }
    
  //anti gravity
  if (infoTime==0 && saAntiGravity) {
    gravity = 0.5;
    maxSpeed = saMaxSpeed;
    saAntiGravity = false;
  }
  
  //gravity
  if (saGravity && infoTime==0) {
    gravity = 0.5;
    saGravity = false;
  }
  
  //laser
  if (laserOn > 0) 
    laserOn--;
  
  //freeze
  if (saFreeze > 0)
    saFreeze--;
    
  //giant bullet
  if (saGiantBullet>=0) {
    saGiantBullet--;
    if (saGiantBullet==0)
      size = 10;
  }
  
  //giant bullet
  if (saFireBullet>=0) {
    saFireBullet--;
    if (saFireBullet==0) {
      size = 10;
      bulletColor = color(0);
    }
  }
  
  //firework bullet
  if (saFireWorkBullet>=0) {
    saFireWorkBullet--;
    if (saFireWorkBullet==0)
      bulletColor = color(0);
  }
  
  //big ball
  if (saBigBall>=0) {
    saBigBall--;
    if (saBigBall==0) {
      minSize -= 10;
      midSize -= 12;
      maxSize -= 15;
    }
  }
}


boolean checkLose () {
  if (health<=0) {
    fill(0,0,255);
    String s = "YOU LOST!\nPop Count " + toString(popCount) + "\nBullet Count " + toString(bulletCount); 
    if (bulletCount !=0)
      s += "\nAccuracy " + toString(popCount*100/(bulletCount)) + "%";
    else
      s += "\nAccuracy N/A";
    s += "\nPress mouse to play again";
    text(s,width/2,height/2);
    fill(0,0,255);
    rectMode(CORNERS);
    rect(width/6,height*3/4,width/6+200,height*3/4+70);
    fill(255);
    text("PLAY AGAIN",width/6+25,height*3/4+45);
    rectMode(CENTER);
    return true;
  }
  return false;
}


void printInfo () {
  fill(0);
  textFont(font);
  text("Health          " + toString(health),25,30);
  text("Pop Count      " + toString(popCount),25,60);
  text("Bullet Count      " + toString(bulletCount),250,30);
  if (bulletCount !=0)
    text("Accuracy       " + toString(popCount*100/(bulletCount)) + "%",250,60);
  else
    text("Accuracy       N/A",250,60);
  if (infoTime>0) {
    fill(255,0,0);
    textFont(bigfont);
    text(info,25,150);
    infoTime--;
  }
}  


void createBall () {
  if (saFreeze>0)
    return;
  
  if (ballRate<10)
    ballRate = 10;
  
  if (frameCount%(ballRate*15)==0) {
    createSpecialBall();
    return;
  }
  
  if (frameCount%ballRate==0) {
    float tmp = (int) random(0,4);
    float tmp_r = random(minSize,midSize);
    float tmp_x;
    float tmp_vy = random(0,15);
    float tmp_vx;
    
    if (tmp%2==0) {
      tmp_x = width + random(0,100);
      tmp_vx = random(-maxSpeed,0);
    } else {
      tmp_x = - random(0,100);
      tmp_vx = random(0,maxSpeed);
    }
    
    ballList = (Ball []) append(ballList, new Ball(tmp_x,groundHeight-tmp_r,tmp_vx,tmp_vy,tmp_r));
  }
}


void createSpecialBall () {
    int tmp = (int) random(0,17);
    float tmp_r = random(midSize,maxSize);
    float tmp_x;
    float tmp_y = random(tmp_r,groundHeight-tmp_r);
    float tmp_vx;
    float tmp_vy = random(0,15);
    
    if (tmp%2==0) {
      tmp_x = width + random(0,100);
      tmp_vx = random(-maxSpeed*1.5,0);
    } else {
      tmp_x = - random(0,100);
      tmp_vx = random(0,maxSpeed*1.5);
    }
    //ballList = (Ball []) append(ballList, new VerticalShootBall(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r));
    
    switch (tmp) {
      case 0: ballList = (Ball []) append(ballList, new DecreaseRateBall(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r)); break;
      case 1: ballList = (Ball []) append(ballList, new HealthBall(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r)); break;
      case 2: ballList = (Ball []) append(ballList, new ClearBall(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r)); break;
      case 3: ballList = (Ball []) append(ballList, new SlowBall(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r)); break;
      case 4: ballList = (Ball []) append(ballList, new ExplosiveBall(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r)); break;
      case 5: ballList = (Ball []) append(ballList, new AntiGravityBall(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r)); break;
      case 6: ballList = (Ball []) append(ballList, new GravityBall(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r)); break;
      case 7: ballList = (Ball []) append(ballList, new PushBackBall(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r)); break;
      case 8: ballList = (Ball []) append(ballList, new LaserBall(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r)); break;
      case 9: ballList = (Ball []) append(ballList, new FreezeBall(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r)); break;
      case 10: ballList = (Ball []) append(ballList, new GiantBulletBall(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r)); break;
      case 11: ballList = (Ball []) append(ballList, new FireBulletBall(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r)); break;
      case 12: ballList = (Ball []) append(ballList, new FireWorkBall(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r)); break;
      case 13: ballList = (Ball []) append(ballList, new FastBulletBall(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r)); break;
      case 14: ballList = (Ball []) append(ballList, new BigBall(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r)); break;
      case 15: ballList = (Ball []) append(ballList, new HorizontaShootBall(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r)); break;
      case 16: ballList = (Ball []) append(ballList, new VerticalShootBall(tmp_x,tmp_y,tmp_vx,tmp_vy,tmp_r));
    }
    
}


void moveBalls () {
  stroke(0);
  for (int i=0; i<ballList.length; i++) {
    if (ballList[i].status==1) 
      continue;
    ballList[i].move();
    ballList[i].show();
  }
}

void moveBullets () {
  fill(bulletColor);
  noStroke();
  for (int i=0; i<bulletList.length; i++) {
    if (bulletList[i].status==1) 
      continue;
    bulletList[i].move();
    bulletList[i].show();
  }
}

void specialShoot () {
  //horizontal shoot
  if (hShoot) {
    for (int i=0; i<hbulletList.length; i++) {
      hbulletList[i].move();
      hbulletList[i].show();
    }
    if (frameCount%hshootRate == 0) {
      hbulletList = (HBullet []) append(hbulletList, new HBullet(7));
      hbulletList = (HBullet []) append(hbulletList, new HBullet(-7));
    }
  }
  
  //vertical shoot
  if (vShoot) {
    for (int i=0; i<vbulletListL.length; i++) {
      vbulletListL[i].move();
      vbulletListL[i].show();
    }
    for (int i=0; i<vbulletListR.length; i++) {
      vbulletListR[i].move();
      vbulletListR[i].show();
    }
    if (frameCount%hshootRate == 0) {
      vbulletListL = (VBullet []) append(vbulletListL, new VBullet(-15,width/2-100,groundHeight));
      vbulletListR = (VBullet []) append(vbulletListR, new VBullet(-15,width/2+100,groundHeight));
    }
  }
}
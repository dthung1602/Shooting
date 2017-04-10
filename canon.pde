class Canon {
  color baseColor = color(100);
  color canonColor = color(50);
  int radius = 35;
  int clength = 100;
  int cwidth = 30;
  Bullet b[] = new Bullet [0];
  
  Canon () {}
  
  void show () {
    //draw path
    if (laserOn>0)
      stroke(255,100,10);
    else 
      stroke(0);
    fill(255,100,10);
     
    float vx = (mouseX-width/2.0)/20;
    float vy = (mouseY-groundHeight)/20;
    float tmpx = width/2+vx;
    float tmpy = groundHeight+vy+gravity;
    float px = width/2;
    float py = groundHeight;
    
    while (tmpy < groundHeight + 10) {
      if (laserOn > 0) 
        laserDestroy(tmpx,tmpy);
      line(px,py,tmpx,tmpy);
      px = tmpx;
      py = tmpy;
      vy += gravity;
      tmpx += vx * saFastBullet;
      tmpy += vy * saFastBullet;
    }
    /*
    //draw canon
    noStroke();
    translate(width/2,groundHeight);
    float a = - atan2(groundHeight-mouseY,mouseX-width/2);
    rotate(a);
    fill(canonColor);
    rect(clength/2,0,clength,cwidth);
    rotate(-a);
    translate(-width/2,-groundHeight);*/
    
    //draw base
    noStroke();
    fill(baseColor);
    ellipse(width/2,groundHeight,radius*2,radius*2);
  }
  
  private void laserDestroy (float tmpx, float tmpy) {
    for (int i=0; i<ballList.length; i++) 
      if (ballList[i].status==0) {
        if (dist(tmpx,tmpy,ballList[i].x,ballList[i].y)<ballList[i].r) {
          ballList[i].status = 1;
          ballList[i].action();
        }
      }
  }
}
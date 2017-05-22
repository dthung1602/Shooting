abstract class VisualEffect implements Cloneable {
  float x, y;          // position of effect
  int timeDefault;     // how long effect last by default
  int time;            // how long effect last 
  
  VisualEffect(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  VisualEffect clone(int x, int y) {
    try {
      VisualEffect ve = (VisualEffect) super.clone();
      ve.x = x;
      ve.y = y;
      ve.time = ve.timeDefault;
      return ve;
    } 
    catch (CloneNotSupportedException e) {
      return null;
    }
  }
  
  void show() {}
}


class FreezeEffect extends VisualEffect {
  int radius = 0;                              // current radius, will increase
  int maxRadius = 100;                         // max radius, equals to shooting radius of ice tower
  int inc;                                     // how much radius will increase in show()
  
  FreezeEffect(float x, float y) {
    super(x, y);
    timeDefault = time = 8;
    inc = (int) map(1,0,time,0,maxRadius);
  }
  
  void show() {
    time -= 1;             // reduce time of effect
    if (time == 0)         // effect has finished
      return;
      
    radius += inc;         // incease radius
    
    //draw circle
    stroke(0,100,255);
    fill(CLEAR_BLUE);
    ellipse(x, y, radius*2, radius*2);
    noStroke();
    
    //draw snowflake
    image(snowflakePic, x, y, radius*2, radius*2);
  }
}


class ExplosionEffect extends VisualEffect {
  int size = 0;                              // current size, will increase
  int maxSize = 400;                         // max size
  int inc;                                   // how much size will increase in show()
  
  ExplosionEffect(float x, float y) {
    super(x, y);
    timeDefault = time = 5;
    inc = (int) map(1,0,time,0,maxSize);
  }
  
  void show() {
    time -= 1;             // reduce time of effect
    if (time == 0)         // effect has finished
      return;
    
    size += inc;           // incease radius
    
    //draw fire
    image(explosionPic, x, y, size, size);
  }
}
abstract class Stuff {
  int x, y;
  int vx = 0, vy = 0;
  PImage img;
  int health;
  
  Stuff (int x, int y) {
    this.x = x;
    this.y = y;
  }
    
  void show () {
    x += vx;
    y += vy;    
    if (y < height - GROUND_HEIGHT)
      vy += GRAVITY;                      // effect of gravity
    image(img, x, y, 200, 200);
  }
  
  void action () {}
}

// tmp class
class ExWall extends Stuff {
  ExWall (int x, int y) {
    super(x, y);
    health = 5;
    img = loadImage("./Pic/wall.png");
  }
}
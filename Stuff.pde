abstract class Stuff {
  float x, y;
  float vx = 0, vy = 0;
  PImage img;
  int health;
  int damage;
  
  Stuff (float x, float y) {
    this.x = x;
    this.y = y;
  }
    
  void show () {}
  
  void action () {}
}
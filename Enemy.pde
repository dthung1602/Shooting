abstract class Enemy {
  int x,y;
  int size;             // how large the enemy is
  int speed;            // a positive number determine how fast it goes
  int attackRange;      // how far the enemy can attack
  int defaultAttackTime;// time between attacks
  int attackTime;       // number of frames left to next attack
  int health;
  int damage;
  int freeze = 0;       // how much time left enemy has to stay still
  int status = 0;       // 0 = alive, 1 = dead
  PImage img;
  
  Enemy (int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  void show () {
    //freeze
    if (freeze > 0) {
      freeze--;
      return;
    }
    
    //move   
    x -= speed;
    if (y + img.height/2 > height - GROUND_HEIGHT)
      y += speed;
    
    //check if enemy has hit house
    if (x < attackRange) { // >>>> fix to check for stuff
      speed = 0;
      attack();
    }
    
    //draw
    image(img, x, y);
  }
  
  void hit (Bullet bl) {
    health -= bl.damage;
    println("hit");
  }
  
  void attack () {
    // delay between attacks
    if (attackTime > 0) {
      attackTime--;
      return;
    }
    
    // attack!
    shooter.health -= damage;
    attackTime = defaultAttackTime;
    println("attack -1");
  }
}


class BasicEnemy extends Enemy {
  BasicEnemy (int x, int y) {
    super(x, y);
    health = 1;
    speed  = 2;
    damage = 1;
    size = 20;
    defaultAttackTime = 50;
    attackTime = 0;
    img = loadImage("./Pic/dart_monkey.png");
    attackRange = 100;
  }
}


class FastEnemy extends Enemy {
  FastEnemy (int x, int y) {
    super(x, y);
    health = 1;
    speed  = 6;
    damage = 1;
    //img     
  }
}


class FlyEnemy extends Enemy {
  FlyEnemy (int x, int y) {
    super(x, y);
    health = 2;
    speed  = 4;
    damage = 1;
    //img     
  }
}


class StrongEnemy extends Enemy {
  StrongEnemy (int x, int y) {
    super(x, y);
    health = 4;
    speed  = 2;
    damage = 2;
    //img     
  }
}
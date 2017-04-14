abstract class Enemy {
  int x,y;
  int size;             // how large the enemy is
  int defaultSpeed;     // a positive number determine how fast it goes at default
  int speed;            // a positive number determine how fast it is currently going
  int attackRange;      // how far the enemy can attack
  int defaultAttackTime;// time between attacks
  int attackTime;       // number of frames left to next attack
  int health;
  int damage;
  int freeze = 0;       // how much time left enemy has to stay still
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
    
    //check if enemy was block by a stuff  
    for (int i=0; i<stuffCount; i++) {
      // skip out-of-game stuffs
      if (stuffList[i].health <= 0) 
        continue;
      
      // skip pass-able stuffs
      if (stuffList[i].walkthrough)
        continue;
      
      // check if stuff block enemy
      if (!stuffList[i].containPoint(x, y)) 
        continue;
      
      //stop and attack stuff
      speed = 0;
      attack(stuffList[i]);
      
      break;
    }
        
    // check if enemy can attact house
    if (x - shooter.x < attackRange) {
      speed = 0;
      attack(shooter);
    }
    
    //draw
    image(img, x, y);
  }
  
  void hit (Bullet bl) {
    health -= bl.damage;
    println("hit");
  }
  
  void hit (AttackableStuff st) {
    health -= st.damage;
  }
  
  void attack (CanBeAttacked target) {
    // delay between attacks
    if (attackTime > 0) {
      attackTime--;
      return;
    }
    
    // attack!
    target.health -= damage;
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
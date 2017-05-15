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
  int bonusMoney;
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
    
    //check if enemy was block by a obj  
    for (int i=0; i<round.objCount; i++) {
      // skip out-of-game objs
      if (objList[i].health <= 0) 
        continue;
      
      // skip pass-able objs
      if (objList[i].walkthrough)
        continue;
      
      // check if obj block enemy
      if (!objList[i].containPoint(x, y)) 
        continue;
      
      //stop and attack obj
      speed = 0;
      attack(objList[i]);
      
      break;
    }
    
    //move   
    x -= speed;
    if (y + img.height/2 > height - GROUND_HEIGHT)
      y += speed;
    
    speed = defaultSpeed;
        
    // check if enemy can attact house
    if (x - shooter.x < attackRange) {
      speed = 0;
      attack(shooter);
    }
    
    //draw
    image(img, x, y);
  }
  
  void hit (Bullet bl) {
    health -= bl.damage + shooter.upgradeList[7].value;
    if (health <= 0) {
      shooter.money += bonusMoney * shooter.upgradeList[4].value;
      round.killCount++;
    }
  }
  
  void hit (ExplosiveObj obj) {
    health -= obj.damage + shooter.upgradeList[7].value;
    if (health <= 0) {
      shooter.money += bonusMoney * shooter.upgradeList[4].value;
      round.killCount++;
    }
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
  }
}


class BasicEnemy extends Enemy {
  BasicEnemy (int x, int y) {
    super(x, y);
    health = 1;
    speed  = 1;
    damage = 5;
    size = 20;
    defaultAttackTime = 50;
    defaultSpeed = 1;
    attackTime = 0;
    img = basicEnemyPic;//loadImage("./Pic/dart_monkey.png");
    attackRange = 100;
    bonusMoney = 5;
  }
}


class FastEnemy extends Enemy {
  FastEnemy (int x, int y) {
    super(x, y);
    health = 1;
    speed  = 3;
    damage = 5;
    size = 20;
    defaultAttackTime = 30;
    defaultSpeed = 3;
    attackTime = 0;
    img = loadImage("./Pic/ice_tower.png");
    attackRange = 100;
    bonusMoney = 8;     
  }
}


class FlyEnemy extends Enemy {
  FlyEnemy (int x, int y) {
    super(x, y);
    health = 1;
    speed  = 2;
    damage = 5;
    size = 20;
    defaultAttackTime = 50;
    defaultSpeed = 2;
    attackTime = 0;
    img = loadImage("./Pic/bomb_tower.png");
    attackRange = 100;
    bonusMoney = 5;    
  }
}


class StrongEnemy extends Enemy {
  StrongEnemy (int x, int y) {
    super(x, y);
    health = 1000;
    speed  = 2;
    damage = 5;
    size = 20;
    defaultAttackTime = 50;
    defaultSpeed = 2;
    attackTime = 0;
    img = loadImage("./Pic/super_monkey.png");
    attackRange = 100;
    bonusMoney = 5;     
  }
}
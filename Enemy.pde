abstract class Enemy {
  // movement
  int x,y;
  int defaultSpeed;     // a positive number determine how fast it goes at default
  int speed;            // a positive number determine how fast it is currently going
  int freeze = 0;       // how much time left enemy has to stay still
  
  // attack
  int attackRange;      // how far the enemy can attack
  int defaultAttackTime;// time between attacks
  int attackTime;       // number of frames left to next attack
  int damage;
  
  // kill
  int health;
  int bonusMoney;
  
  // display
  int w, h;
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
    bonusMoney = 5;
    
    speed  = 1;
    defaultSpeed = 1;
    
    damage = 5;
    defaultAttackTime = 50;
    attackTime = 0;
    attackRange = 100;
    
    img = basicEnemyPic;
    w = img.width/2;
    h = img.height/2;
  }
}


class FastEnemy extends Enemy {
  FastEnemy (int x, int y) {
    super(x, y);
    health = 1;
    bonusMoney = 10;
    
    speed  = 3;
    defaultSpeed = 3;
    
    damage = 5;
    defaultAttackTime = 50;
    attackTime = 0;
    attackRange = 100;
    
    img = fastEnemyPic;
    w = img.width/2;
    h = img.height/2;
  }
}


class FlyEnemy extends Enemy {
  FlyEnemy (int x, int y) {
    super(x, y);
    health = 2;
    bonusMoney = 18;
    
    speed  = 4;
    defaultSpeed = 4;
    
    damage = 4;
    defaultAttackTime = 40;
    attackTime = 0;
    attackRange = 100;
    
    img = flyEnemyPic;
    w = img.width/2;
    h = img.height/2;  
  }
}


class StrongEnemy extends Enemy {
  StrongEnemy (int x, int y) {
    super(x, y);
    health = 5;
    bonusMoney = 25;
    
    speed = 2;
    defaultSpeed = 2;
    
    damage = 8;
    defaultAttackTime = 30;
    attackTime = 0;
    attackRange = 100;
    
    img = strongEnemyPic;
    w = img.width/2;
    h = img.height/2;
  }
}
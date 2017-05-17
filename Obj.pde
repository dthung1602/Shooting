abstract class Obj extends CanBeAttacked implements Cloneable {
  // info
  String name;
  String explaination;
  
  // limit 
  int price;      // price for enable obj
  int cost;       // cost for buying 1 new obj in game
  //? int time;
  //? int defaultTime;
  
  // display
  int x, y;
  int x1, y1, x2, y2;
  int vx = 0, vy = 0;
  transient PImage img;
  
  //other
  boolean walkthrough;
  boolean enable;

  Obj () {
  }

  void show () {
    x += vx;
    y += vy;    
    if (y < height - GROUND_HEIGHT)
      vy += GRAVITY;                      // effect of gravity
    image(img, x, y);
  }

  boolean containPoint (float xx, float yy) {
    if (x1 < xx && xx < x2 && y1 < yy && yy < y2)
      return true;
    return false;
  }

  Obj clone() {
    // check if enough money
    if (shooter.money < cost) {
      screen.info.message = "Not enough money";
      screen.info.time    = MESSAGE_TIME_SHORT;
      return null;
    }
    
    // clone new obj
    try {
      shooter.money -= cost;
      return (Obj) super.clone();
    } 
    catch (CloneNotSupportedException e) {
      return null;
    }
  }

  void action () {
  }
}


abstract class ExplosiveObj extends Obj {
  int damage;
  int explosionRadius;

  void action () {
    health = 0;
    effectList[round.effectCount] = new ExplosionEffect(x, y);
    round.effectCount++;
    for (int i=0; i<round.enemyCount; i++) {
      if (enemyList[i].health > 0 && touch(enemyList[i])) {
        enemyList[i].hit(this);
      }
    }
  }

  private boolean touch (Enemy e) {
    if (dist(e.x, e.y, x, y) < explosionRadius * shooter.upgradeList[8].value)
      return true;
    return false;
  }
}


class Wall extends Obj {
  Wall () {
    name = "Wall";
    explaination = "Block enemies.\nHealth: \nCost: \nPrice";
    
    price  = 200;
    cost   = 20;
    health = 50;
    
    img = wallPic;
    x1 = x - img.width/2;
    x2 = x + img.width/2;
    y1 = y - img.height/2;
    y2 = y + img.height/2;
    
    walkthrough = false;
    enable = false;
  }
}

class BigWall extends Obj {
  BigWall () {
    name = "Big Wall";
    explaination = "Block more enemies.\n";
    
    price  = 400;
    cost   = 40;
    health = 100;
    
    img = wallPic;
    x1 = x - img.width/2;     
    x2 = x + img.width/2;     
    y1 = y - img.height/2;     
    y2 = y + img.height/2;
    
    walkthrough = false;
    enable = false;
  }
}


class Barrel extends ExplosiveObj {
  Barrel () {
    name = "Barrel";
    explaination = "Can explode when hit by a bullet.\n";
    
    price  = 600;
    cost   = 60;
    health = 1;
    
    img = barrelPic;
    x1 = x - img.width/2;
    x2 = x + img.width/2;     
    y1 = y - img.height/2;     
    y2 = y + img.height/2;
    
    damage = 1;
    explosionRadius = 30;
    
    walkthrough = true;
    enable = false;
  }
}


class ToxicBarrel extends ExplosiveObj {
  ToxicBarrel () {
    name = "Toxic Barrel";
    explaination = "Can explode when hit by a bullet.\n";
    
    price  = 800;
    cost   = 80;
    health = 1;
    
    img = barrelPic;
    x1 = x - img.width/2;
    x2 = x + img.width/2;
    y1 = y - img.height/2;
    y2 = y + img.height/2;
    
    damage = 2;
    explosionRadius = 40;
    
    walkthrough = true;
    enable = false;
  }
}
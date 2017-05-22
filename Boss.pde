class Boss extends Enemy {
  int bossNum;
  int delayMax;
  int delayMin;
  int delay;
  EnemyBullet slowBullet;
  float bulletSpeed;
  FreezeEffect fastAttack;
  ExplosionEffect slowAttack;
  int fastAttackPosibility;
  int slowAttackPosibility;
  int createEnemyibility;
  int position;
  int x [];
  int y [];

  Boss (int bossNum) {
    super(width, height/2);
    health = 50;
    damage = 7;
    bulletSpeed = 2;
    fastAttack = new FreezeEffect(0, 0);
    slowAttack = new ExplosionEffect(0, 0);

    // load image
    img = loadImage("./Pic/World/world" + bossNum + "/boss.png");
    
    // read path from file
    // file structure:
    // fast_attack_posibility, slow_attack_posibility, create_enemy_posibility, delayMax, delayMin
    // posx posy 
    // ...
    String data [] = loadStrings("./Config/boss/boss" + bossNum + ".txt");
    String tmp [];
    x = new int [data.length];
    y = new int [data.length];

    // set up posibility of boss
    tmp =  split(data[0], " ");
    fastAttackPosibility = int(tmp[0]);
    slowAttackPosibility = int(tmp[1]) + fastAttackPosibility;
    createEnemyibility = int(tmp[2]) + slowAttackPosibility; 
    delayMax = int(tmp[3]);
    delayMin = int(tmp[4]);

    // other properties
    this.bossNum = bossNum;
    delay = (int) random(delayMin, delayMax);

    //put data to x[], y[]
    for (int i=0; i<data.length - 1; i++) {
      tmp = split(data[i], " ");
      x[i] = int(tmp[0]);
      y[i] = int(tmp[1]);
    }
  }

  void show() {
    //freeze
    if (freeze > 0) {
      freeze--;
      return;
    }

    // move
    position = (position == x.length) ? 0 : position + 1;
    x1 = x[position] - img.width/2;
    y1 = y[position] - img.width/2;
    x2 = x[position] + img.height/2;
    y2 = y[position] + img.height/2;
    delay--;

    // action
    if (delay == 0) {
      int p = (int) random(0, 101);        // random number to decide action
      if (p > fastAttackPosibility) 
        fastAttack();
      else if (p > slowAttackPosibility) 
        slowAttack();
      else
        createEnemy();
      delay = (int) random(delayMin, delayMax);        
    }
    
    // show img
    image(img, x[position], y [position]);
  }

  private void fastAttack() {
    effectList[round.effectCount] = fastAttack.clone(x[position], y[position]);
    shooter.health -= damage;
    screen.info.message = "fast att";
    screen.info.time = MESSAGE_TIME_SHORT;
  }

  private void slowAttack() {
    // >>> effectList[round.effectCount] = (VisualEffect) slowAttack.clone();
    
    // calculate speedx, speedy from x, y to shooter
    for (int i=0; i<5; i++) {
      int tmpX = constrain(x[position] + (int) random(-300, 300), 300, width);
      int tmpY = constrain(y[position] + (int) random(-300, 300), 0, height);
      float d = dist(shooter.x, shooter.y, tmpX, tmpY);
      float vx = bulletSpeed * (shooter.x - tmpX) / d;          // x speed
      float vy = bulletSpeed * (shooter.y - tmpY) / d;          // y speed
      enemyBulletList[round.enemyBulletCount] = slowBullet.clone(tmpX, tmpY, vx, vy);
      round.enemyBulletCount++;
    }
    
    
    screen.info.message = "slow att";
    screen.info.time = MESSAGE_TIME_SHORT;
  }

  private void createEnemy() {
    int k, y, p;      
    p = (int) random(3, 6);                      // how many enemy is created in one time
    for (int i=0; i<p; i++) {
      k = (int) random(0, 101);                  // random number to decide enemy to create
      y = height - (int) random(100, 300);       // random y coordinate
      if (k <= 20) {
        enemyList[round.enemyCount] = new BasicEnemy(width, y);
      } else if (k <= 40) {
        enemyList[round.enemyCount] = new FastEnemy(width, y);
      } else if (k <= 70) {
        enemyList[round.enemyCount] = new FlyEnemy(width, y - 200);
      } else {
        enemyList[round.enemyCount] = new StrongEnemy(width, y);
      }
      round.enemyCount++;
    }
  }
}
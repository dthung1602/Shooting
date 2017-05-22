class PlayScreen extends Screen {
  private int countDown;
  private Bar barList[];

  PlayScreen () {
    buttonList = new Button [] {
      new ChangeScreenButton(1132, 0, 1190, 56, 12), // leave game confirm
    };
    buttonList[0].highlight = false;

    infoList = new Info [] {
      new Info("", 20, 25, WHITE, fontSmall), // health
      new Info("", 20, 50, WHITE, fontSmall), // money
      new Info("", 590, 22, WHITE, fontSmall), // bulet left
    };

    barList = new Bar [] {
      new Bar(110, 7, PINK, RED), // health
      new Bar(800, 5, BLUE, DARK_BLUE, true), // weapon special delay
      new Bar(800, 30, BLUE, DARK_BLUE, true), // wp delay
      new Bar(500, 5, DARK_GREEN, GREEN, true), // bullet left
    };
  }

  void show() {
    background(screen.bg);
    image(playPic, 600, 350);

    if (countDown())
      return;

    createEnemy();
    drawObj();
    drawEnemy();
    drawBullet();
    drawEffect();
    shooter.show();

    checkFinishRound();
    checkGameEnd();
    showInfo();
    drawMouse();
  }

  private boolean countDown() {
    // do nothing when finish count down
    if (countDown == 0) 
      return false;

    // adjust text
    fill(RED);
    textFont(fontLarge);

    // show text
    text("ROUND " + (round.currentRound+1), width/2-75, height/2-75);

    if (countDown < (int) frameRate)
      text("1...", width/2, height/2);
    else if (countDown < (int) frameRate * 2)
      text("2...", width/2, height/2);
    else
      text("3...", width/2, height/2);

    countDown--;
    return true;
  }

  private void createEnemy() {
    // check if fighting a boss
    if (round.currentRound == MAX_ROUND - 1) {
      createBoss();
      return;
    }

    // check if enough enemy have been created this round
    if (round.enemyCount == round.totalEnemyInRound) 
      return;

    // create delay time between enemy creation
    if (frameCount < round.oldFrame + round.newEnemyDelay)
      return;

    // create a new enemy base on random numbers
    round.oldFrame = frameCount;
    round.newEnemyDelay = (int) random(MIN_ENEMY_DELAY, MAX_ENEMY_DELAY);
    int k = (int) random(0, 100);
    int y = height - (int) random(100, 300);

    // 100% basic enemy when round <= 5
    if (round.currentRound <= 4) {
      enemyList[round.enemyCount] = new BasicEnemy(width, y);

    // 50% basic, 50% fast
    } else if (round.currentRound <= 8) {
      if (k <= 50) {
        enemyList[round.enemyCount] = new BasicEnemy(width, y);
      } else {
        enemyList[round.enemyCount] = new FastEnemy(width, y);
      }

      // 30% basic, 30% fast, 40% fly
    } else if (round.currentRound <= 12) {
      if (k <= 30) {
        enemyList[round.enemyCount] = new BasicEnemy(width, y);
      } else if (k <= 60) {
        enemyList[round.enemyCount] = new FastEnemy(width, y);
      } else {
        enemyList[round.enemyCount] = new FlyEnemy(width, y - 200);
      }

      // 20% basic, 20% fast, 30% fly, 30% strong
    } else {
      if (k <= 20) {
        enemyList[round.enemyCount] = new BasicEnemy(width, y);
      } else if (k <= 40) {
        enemyList[round.enemyCount] = new FastEnemy(width, y);
      } else if (k <= 70) {
        enemyList[round.enemyCount] = new FlyEnemy(width, y - 200);
      } else {
        enemyList[round.enemyCount] = new StrongEnemy(width, y);
      }
    }

    round.enemyCount++;
  }

  private void createBoss() {
    // create boss at first
    if (round.enemyCount == 0) {
      enemyList[0] = new Boss(round.currentWorld);
      round.enemyCount++;
      return;
    }
  }

  private void drawObj() {
    for (int i=0; i<round.objCount; i++)
      if (objList[i].health > 0)
        objList[i].show();
  }

  private void drawEnemy() {
    for (int i=0; i<round.enemyCount; i++) 
      if (enemyList[i].health > 0)
        enemyList[i].show();
  }

  private void drawEffect() {
    for (int i=0; i<round.effectCount; i++)
      if (effectList[i].time > 0)
        effectList[i].show();
  }

  private void drawBullet() {
    // shooter's bullets
    for (int i=0; i<round.bulletCount; i++)
      if (bulletList[i].status == 0)
        bulletList[i].show();
        
    // enemy's bullets
    for (int i=0; i<round.enemyBulletCount; i++)
      if (enemyBulletList[i].status == 0)
        enemyBulletList[i].show();
  }

  private void checkGameEnd() {
    // check if player has lost
    if (shooter.health <= 0) {
      screen.changeScreen(loseScreen);
      round.reset();
      return;
    }
  }

  private void checkFinishRound() {
    if (round.currentRound == MAX_ROUND - 1) {  // for fighting boss
      if (enemyList[0].health > 0)
        return;
    } else {                        // for normal rounds
      if (round.killCount < round.totalEnemyInRound)
        return;
    }

    // finish round
    round.reset();
    round.currentRound++;
    round.totalEnemyInRound *= DIFICULTLY;
    screen.changeScreen(upgradeScreens[0]);

    // update money info in upgrade screen
    upgradeScreens[0].infoList[12].message = str(shooter.money);
    upgradeScreens[1].infoList[12].message = str(shooter.money);
    upgradeScreens[2].infoList[8].message = str(shooter.money);
    upgradeScreens[3].infoList[8].message = str(shooter.money);

    // save game, unlock new round
    if (round.currentWorld == player.maxWorld)
      player.maxRound++;
    player.savePlayer();

    // check if player win current world
    if (round.currentRound == MAX_ROUND && round.currentWorld == player.maxWorld) {
      player.maxWorld++;
      player.maxRound = 0;
      // >> check if win all world
      screen.changeScreen(winScreen);
    }
  }

  private void showInfo() {
    // update info
    infoList[0].message = "Health                  " + shooter.health + "/" + int(shooter.upgradeList[1].value);
    infoList[1].message = "Money       $" + shooter.money;
    infoList[2].message = (shooter.currentWeapon.bulletLeft < 0) ? "Infinity" : shooter.currentWeapon.bulletLeft + "/" + (int) barList[3].max;

    // update bar
    barList[0].value = shooter.health;
    barList[1].value = shooter.currentWeapon.delaySpecial;
    barList[2].value = shooter.currentWeapon.delay;
    barList[3].value = shooter.currentWeapon.bulletLeft;    

    // show bars
    for (int i=0; i<barList.length; i++) 
      barList[i].show();

    // show info
    for (int i=0; i<infoList.length; i++) 
      infoList[i].show();
    info.show();
  }

  private void drawMouse() {
    //high light if mouse on any button
    Button b;
    for (int i=0; i<buttonList.length; i++) {
      b = buttonList[i]; 
      if (b.containPoint(mouseX, mouseY) && b.enable && b.highlight) {
        noStroke();
        fill(BLUE);
        rect(b.x1, b.y1, b.x2, b.y2);
        return;
      }
    }

    //draw obj
    if (shooter.currentObj != null) {
      shooter.currentObj.x = mouseX;
      shooter.currentObj.y = mouseY;
      image(shooter.currentObj.img, mouseX, mouseY, 100, 100);
    }
  }

  private class Bar {
    int x, y;
    color bgColor, fgColor;
    float max;
    float value;
    int w = 20, l = 250;
    boolean reverse = false;

    Bar (int x, int y, color bgColor, color fgColor) {
      this.x = x;
      this.y = y;
      this.bgColor = bgColor;
      this.fgColor = fgColor;
    }

    Bar (int x, int y, color bgColor, color fgColor, boolean reverse) {
      this.x = x;
      this.y = y;
      this.bgColor = bgColor;
      this.fgColor = fgColor;
      this.reverse = reverse;
    }

    void show() {
      rectMode(CORNERS);
      noStroke();
      fill(bgColor);

      int percent;
      if (value < 0)
        percent = l;
      else if (max == 0)
        percent = 0;
      else
        percent = (int) map(value, 0, max, 0, l);

      rect(x, y, x + l, y + w);
      fill(fgColor);
      if (reverse)
        rect(x + percent, y, x + l, y + w);
      else 
      rect(x, y, x + percent, y + w);
    }
  }

  void updateBars() {
    playScreen.barList[0].max = shooter.upgradeList[1].value;
    playScreen.barList[1].max = shooter.currentWeapon.defaultSpecialDelay * shooter.upgradeList[5].value;
    playScreen.barList[2].max = shooter.currentWeapon.defaultDelay * shooter.upgradeList[2].value;
    playScreen.barList[3].max = shooter.currentWeapon.bulletLeft;
  }
}
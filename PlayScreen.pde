class PlayScreen extends Screen {
  PlayScreen () {
    bg = loadImage("./Pic/map0.jpg");
    buttonList = new Button [] {
      new NewObjButton(0, 0, 100, 100, 0),
      new NewObjButton(100, 0, 200, 100, 1),
      new NewObjButton(200, 0, 300, 100, 2),
      new NewObjButton(0, 100, 100, 200, 3),
    };
    
    infoList = new Info [] {
      new Info("" + str(shooter.health), 50, 450, color(255,0,0), fontSmall),
      new Info("" + str(shooter.money), 50, 475, color(255,0,0), fontSmall),
      new Info("" + str(currentRound), 50, 500, color(255,0,0), fontSmall),
    };    
  }
  
  void show() {
    background(screen.bg);
    createEnemy();
    
    drawObj();
    drawEnemy();
    drawBullet();
    drawEffect();
    shooter.show();
    
    checkGameEnd();
    checkFinishRound();
    showInfo();
    drawMouse();
  }
  
  private void createEnemy() {
    // check if enough enemy have been created this round
    if (enemyCount == totalEnemyInRound) 
      return;
      
    // create delay time between enemy creation
    if (frameCount < oldFrame + newEnemyDelay)
      return;
      
    // create a new enemy base on random numbers
    oldFrame = frameCount;
    newEnemyDelay = (int) random(MIN_ENEMY_DELAY, MAX_ENEMY_DELAY);
    int k = (int) random(0, 100);
    int y = height - (int) random(100, 300);
    
    // 100% basic enemy when round <= 5
    if (currentRound <= 4) {
      enemyList[enemyCount] = new BasicEnemy(width, y);
      
    // 50% basic, 50% fast
    } else if (currentRound <= 8) {
      if (k <= 50) {
        enemyList[enemyCount] = new BasicEnemy(width, y);
      } else {
        enemyList[enemyCount] = new FastEnemy(width, y);
      }
      
    // 30% basic, 30% fast, 40% fly 
    } else if (currentRound <= 12) {
      if (k <= 30) {
        enemyList[enemyCount] = new BasicEnemy(width, y);
      } else if (k <= 60) {
        enemyList[enemyCount] = new FastEnemy(width, y);
      } else {
        enemyList[enemyCount] = new FlyEnemy(width, y - 200);
      }
    
    // 20% basic, 20% fast, 30% fly, 30% strong
    } else {
      if (k <= 20) {
        enemyList[enemyCount] = new BasicEnemy(width, y);
      } else if (k <= 40) {
        enemyList[enemyCount] = new FastEnemy(width, y);
      } else if (k <= 70) {
        enemyList[enemyCount] = new FlyEnemy(width, y - 200);
      } else {
        enemyList[enemyCount] = new StrongEnemy(width, y);
      }
    }
    
    enemyCount++; 
  }
  
  private void drawObj() {
    for (int i=0; i<objCount; i++)
      if (objList[i].health > 0)
        objList[i].show();
  }
  
  private void drawEnemy() {
    for (int i=0; i<enemyCount; i++) 
      if (enemyList[i].health > 0)
        enemyList[i].show();
  }
  
  private void drawEffect() {
    for (int i=0; i<effectCount; i++)
      if (effectList[i].time > 0)
        effectList[i].show();
  }
  
  private void drawBullet() {
    for (int i=0; i<bulletCount; i++)
    if (bulletList[i].status == 0)
      bulletList[i].show();
  }
  
  private void checkGameEnd() {
    // check if player has lost
    if (shooter.health <= 0) {
      screen.changeScreen(loseScreen);
      resetRound();
      return;
    }
    
    // check if player has win 
    if (currentRound > MAX_ROUND)
      screen.changeScreen(winScreen);
  }
  
  private void checkFinishRound() {
    // have not finish round
    if (killCount < totalEnemyInRound)
      return;
      
    // finish round
    resetRound();
    currentRound++;
    totalEnemyInRound *= DIFICULTLY;
    screen.changeScreen(upgradeScreens[0]);
    screen.infoList[12].message = str(shooter.money);
    
    // save game, unlock new round & check highscore
    //>>>>>>>
    player.savePlayer();
  }
  
  private void showInfo() {
    // update health, round and money
    infoList[0].message = "Health: " + str(shooter.health);
    infoList[1].message = "Money : " + str(shooter.money);
    infoList[2].message = "Round : " + str(currentRound);
    
    for (int i=0; i<infoList.length; i++) 
      infoList[i].show();
    info.show();
  }
  
  private void drawMouse() {
    //high light if mouse on any button
    Button b;
    for (int i=0; i<buttonList.length; i++) {
      b = buttonList[i]; 
      if (b.containPoint(mouseX, mouseY) && b.enable) {
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
}
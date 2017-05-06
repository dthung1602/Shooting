int hash (String string) {
  int h = 7;
  for (int i = 0; i < string.length(); i++) {
    h = h*31 + string.charAt(i);
  }
  return h;
}

void resetRound() {
  killCount      = 0;
  enemyCount     = 0;
  bulletCount    = 0;
  effectCount    = 0;
  objCount     = 0;
  shooter.health = (int) shooter.upgradeList[1].value;
  oldFrame       = frameCount;
  newEnemyDelay  = (int) random(MIN_ENEMY_DELAY, MAX_ENEMY_DELAY);
  totalEnemyInRound = (int) (DEFAULT_ENEMY_NUM * pow(DIFICULTLY, currentRound));
  //>> reset special abilities
}

void resetUpgrade() {
}

void resetAll() {
  resetRound();
  resetUpgrade();
  shooter.money  = DEFAULT_MONEY;
  shooter.health = DEFAULT_HEALTH;
  shooter.upgradeList[1].value = DEFAULT_HEALTH;
  currentRound = 1;
}



void loadInfo() {
  //>>> load upgrade info
  //>>> load weapon info
  //>>> load info to upgrade screens
}

Weapon weaponType(int wpNum) {
  switch (wpNum) {
  case 0: 
    return new HandStone();
  case 1: 
    return new HandShuriken();
  case 2: 
    return new Bow();
  case 3: 
    return new HandGrenade();
  case 4: 
    return new FreezeGun();
  default: 
    return new LaserGun();
  }
}

void updatePlayerList() {
  // load data from file
  String data [] = loadStrings("./Player/player.txt");
  changePlayerScreen.infoList = new Info [data.length + 2];  

  // info[0]: username, info[1]: password
  changePlayerScreen.infoList[0] = new Info("", 375, 370, BOLD_RED, fontMedium);
  changePlayerScreen.infoList[1] = new Info("", 375, 465, BOLD_RED, fontMedium);
  changePlayerScreen.infoList[1].hiden = true;

  // all user names
  for (int i=0; i<data.length; i++) {
    changePlayerScreen.infoList[i+2] = new Info(data[i], 200 + 210 * (i / 3), 150 + (i % 3) * 50, BOLD_RED, fontMedium);
  }
}
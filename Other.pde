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
  String data [];
  String tmp [];
  
  //>>> load weapon info
  data = loadStrings("./Config/weapon.txt");
  for (int i=0; i<data.length; i++) {
    tmp = split(data[i], '_');
    shooter.weaponList[i].name = tmp[0];
    shooter.weaponList[i].explaination = tmp[1];
  }
  
  //>>> load upgrade info
  data = loadStrings("./Config/upgrade.txt");
  for (int i=0; i<data.length; i++) {
    tmp = split(data[i], '_');
    shooter.upgradeList[i].name = tmp[0];
    shooter.upgradeList[i].explaination = tmp[1];
  }
  
  //>>> load info to upgrade screens
  upgradeScreens[0].infoList = new Info [8];
  upgradeScreens[1].infoList = new Info [8];
  for (int i=0; i<shooter.upgradeList.length; i++) 
    upgradeScreens[i/6].infoList[i%6] = new Info(shooter.upgradeList[i].name, 250 + 470 * (i%6 / 3), 275 + (i%6 % 3) * 120, YELLOW_BOLD, fontMedium);
  upgradeScreens[0].infoList[6] = upgradeScreens[1].infoList[6] = new Info("money", 340, 178, BROWN, fontMedium);
  upgradeScreens[0].infoList[7] = upgradeScreens[1].infoList[7] = new Info("explain", 600, 145, BROWN, fontMedium);
  
  upgradeScreens[2].infoList = new Info [6];
  upgradeScreens[3].infoList = new Info [6];
  for (int i=0; i<shooter.weaponList.length; i++) 
    upgradeScreens[i/4 + 2].infoList[i%4] = new Info(shooter.weaponList[i].name, 290, 290 + (i % 4) * 87, BROWN, fontMedium);
  upgradeScreens[2].infoList[4] = upgradeScreens[3].infoList[4] = new Info("money", 340, 178, BROWN, fontMedium);
  upgradeScreens[2].infoList[5] = upgradeScreens[3].infoList[5] = new Info("explain", 600, 145, BROWN, fontMedium);
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
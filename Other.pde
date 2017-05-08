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
    shooter.weaponList[i].explaination = tmp[1].replace("\\n", "\n");
  }

  //>>> load upgrade info
  data = loadStrings("./Config/upgrade.txt");
  for (int i=0; i<data.length; i++) {
    tmp = split(data[i], '_');
    shooter.upgradeList[i].name = tmp[0];
    shooter.upgradeList[i].explaination = tmp[1].replace("\\n", "\n");
    ;
  }

  //>>> load upgrade info to upgrade screens
  upgradeScreens[0].infoList = new Info [14];
  upgradeScreens[1].infoList = new Info [14];
  for (int i=0; i<shooter.upgradeList.length; i++)
    upgradeScreens[i/6].infoList[i%6] = new Info(shooter.upgradeList[i].name, 250 + 470 * (i%6 / 3), 275 + (i%6 % 3) * 120, YELLOW_BOLD, fontMedium);
  upgradeScreens[0].infoList[12] = upgradeScreens[1].infoList[12] = new Info("", 340, 178, BROWN, fontMedium);
  upgradeScreens[0].infoList[13] = upgradeScreens[1].infoList[13] = new Info("Hoover mouse over buttons\nfor more infomation", 600, 145, BROWN, fontMedium);

  //>>> load weapon info to upgrade screens
  upgradeScreens[2].infoList = new Info [10];
  upgradeScreens[3].infoList = new Info [10];
  for (int i=0; i<shooter.weaponList.length; i++) 
    upgradeScreens[i/4 + 2].infoList[i%4] = new Info(shooter.weaponList[i].name, 290, 290 + (i % 4) * 87, BROWN, fontMedium);
  upgradeScreens[2].infoList[8] = upgradeScreens[3].infoList[8] = new Info("", 340, 178, BROWN, fontMedium);
  upgradeScreens[2].infoList[9] = upgradeScreens[3].infoList[9] = new Info("Hoover mouse over buttons\nfor more infomation", 600, 145, BROWN, fontMedium);
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

void loadWorld (int worldNum) {
  playScreen.bg = loadImage("./Pic/World/world" + worldNum + ".png");
  //>> load more pic
}

void updateBars() {
  playScreen.barList[0].max = shooter.upgradeList[1].value;
  playScreen.barList[1].max = shooter.currentWeapon.defaultSpecialDelay * shooter.upgradeList[5].value;
  playScreen.barList[2].max = shooter.currentWeapon.defaultDelay * shooter.upgradeList[2].value;
  playScreen.barList[3].max = shooter.currentWeapon.bulletLeft;
  println();
}
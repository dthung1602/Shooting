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

void login () {  
  // check if username in list
  boolean inList = false;
  for (int i=2; i<changePlayerScreen.infoList.length; i++) {
    if (changePlayerScreen.infoList[i].message.equals(changePlayerScreen.infoList[0].message)) {
      inList = true;
      break;
    }
  }

  // if not in list of existing users
  if (!inList) {
    changePlayerScreen.infoList[0].message = "";
    changePlayerScreen.infoList[1].message = "";
    changePlayerScreen.infoList[1].input = false;
    changePlayerScreen.status = 0;
    changePlayerScreen.infoList[0].input = true;
    screen.info.message = "Invalid username!";
    screen.info.time = 75;
    return;
  }

  // read player's file for pass
  String data [] = loadStrings("./Player/" + changePlayerScreen.infoList[0].message + ".txt");

  // if wrong pass
  if (hash(changePlayerScreen.infoList[1].message) != int(data[0])) {
    changePlayerScreen.infoList[1].message = "";
    screen.info.message = "Wrong password!";
    screen.info.time = 75;
    return;
  }

  // pass is correct
  screen = menuScreen;
  surface.setSize(screen.bg.width, screen.bg.height);
  player.loadPlayer();
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
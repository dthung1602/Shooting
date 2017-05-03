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
  shooter.health = shooter.maxHealth;
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
  shooter.maxHealth = DEFAULT_HEALTH;
  currentRound = 1;
}

void login () {
  // check lalid name
  
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
    changePlayerScreen.status = 0;
    screen.info.message = "Invalid username!";
    screen.info.time = 75;
    return;
  }

  // read player's file for pass
  String data [] = loadStrings("./Player/" + changePlayerScreen.infoList[0].message + ".txt");

  // if wrong pass
  if (hash(changePlayerScreen.infoList[1].message) != int(data[0])) {
    changePlayerScreen.infoList[1].message = "";
    screen.info.message = "Invalid password!";
    screen.info.time = 75;
    return;
  }

  // pass is correct
  screen = menuScreen;
  surface.setSize(screen.bg.width, screen.bg.height);
  player.loadPlayer();
}
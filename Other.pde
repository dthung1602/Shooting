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

void newPlayer() {
  // check if pass and re-pass are the same
  if (!newPlayerScreen.infoList[1].message.equals(newPlayerScreen.infoList[2].message)) {
    newPlayerScreen.info.message = "Password and re-password do not match!";
    newPlayerScreen.info.time = 50;
    newPlayerScreen.status = 1;
    newPlayerScreen.infoList[0].input = false;
    newPlayerScreen.infoList[1].input = true;
    newPlayerScreen.infoList[2].input = false;
    newPlayerScreen.infoList[1].message = newPlayerScreen.infoList[2].message = "";
    return;
  }
  
  // check if player name has been taken and diff from player
  String s [] = loadStrings("./Player/player.txt");
  for (int i=0; i<s.length; i++) 
    if (newPlayerScreen.infoList[0].message.equals(s[i]) || newPlayerScreen.infoList[0].message.equals("player")) {
      newPlayerScreen.info.message = "Player name has been taken. Please choose another name.";
      newPlayerScreen.info.time = 50;
      newPlayerScreen.status = 0;
      newPlayerScreen.infoList[0].input = true;
      newPlayerScreen.infoList[1].input = false;
      newPlayerScreen.infoList[2].input = false;
      newPlayerScreen.infoList[0].message = newPlayerScreen.infoList[1].message = newPlayerScreen.infoList[2].message = "";
      return;
    }    
  
  // save to player's own file
  s = new String [7];
  
  s[0] = str(hash(newPlayerScreen.infoList[1].message));            // password
  s[1] = "1";                                                       // current round
  s[2] = str(DEFAULT_MONEY);
  s[3] = str(DEFAULT_HEALTH);
  s[4] = "true false false false false false";                      // weapon
  s[5] = "false false false false";                                 // obj
  s[6] = "// for upgrades";  //>>>>>>>>>>>
  
  saveStrings("./Player/" + newPlayerScreen.infoList[0].message + ".txt", s);
  
  // add player's name to playerlist
  s = loadStrings("./Player/player.txt");
  s = (String []) append(s, newPlayerScreen.infoList[0].message);
  saveStrings("./Player/player.txt", s);
  
  // auto login and change to menu screen
  changePlayerScreen.infoList[0].message = newPlayerScreen.infoList[0].message;
  changePlayerScreen.infoList[1].message = newPlayerScreen.infoList[1].message;
  screen = menuScreen;
  surface.setSize(screen.bg.width, screen.bg.height);
  player.loadPlayer();
}
class Player {
  String name;
  int money;
  
  int maxWorld;  // max world player can play
  int maxRound;  // max round in that world player can play

  Player() {
  }

  void loadPlayer() {
    // load file
    this.name = changePlayerScreen.infoList[0].message;
    String data [] = loadStrings("./Player/" + this.name + ".txt");
    String tmp [];

    // copy info from file to game
    tmp = split(data[1], ' ');
    maxWorld = int(tmp[0]);
    maxRound = int(tmp[1]);
    shooter.money = int(data[2]);
    shooter.upgradeList[1].value = int(data[3]);

    // create weapon list
    tmp = split(data[4], ' ');
    for (int i=0; i<tmp.length; i++) 
      shooter.weaponList[i].enable = boolean(tmp[i]);

    // enalbe new obj buttons
    tmp = split(data[5], ' ');
    for (int i=0; i<tmp.length; i++) 
      shooter.objList[i].enable = boolean(tmp[i]);

    // load upgrades
    // format: level&value&price level&value&price level&value&price ...
    tmp = split(data[6], ' ');
    String temp [];
    for (int i=0; i<tmp.length; i++) {
      temp = split(tmp[i], '&');
      shooter.upgradeList[i].level = int(temp[0]);
      shooter.upgradeList[i].value = float(temp[1]);
      shooter.upgradeList[i].price = float(temp[2]);
    }

    // load info to upgrade screens
    Upgrade upg;
    for (int i=0; i<shooter.upgradeList.length; i++) {
      upg = shooter.upgradeList[i];
      upgradeScreens[i/6].infoList[i%6+6] = new Info((int) upg.level + "/" + (int) upg.maxLevel, 330 + 470 * (i%6 / 3), 322 + (i%6 % 3) * 120, BROWN, fontMedium);
    }

    for (int i=0; i<shooter.upgradeList.length/6 + 1; i++)
      upgradeScreens[i].infoList[12].message = str(shooter.money);

    for (int i=0; i<shooter.weaponList.length/4 + 1; i++) 
      upgradeScreens[i + shooter.upgradeList.length/6 + 1].infoList[8].message = str(shooter.money);

    // add wellcome in menu screen
    menuScreen.info.message = "Welcome, " + name + "!";
    menuScreen.info.time = MESSAGE_TIME_FOREVER;

    // set playscreen to latest round
    round.currentRound = maxRound;
  }

  void createPlayer () {
    // check if every field is filled
    if (newPlayerScreen.infoList[0].message.length() * newPlayerScreen.infoList[1].message.length() == 0) {
      screen.info.message = "Please fill all infomation";
      screen.info.time = MESSAGE_TIME_LONG;
    }
    
    // check if pass and re-pass are the same
    if (!newPlayerScreen.infoList[1].message.equals(newPlayerScreen.infoList[2].message)) {
      newPlayerScreen.info.message = "Password and re-password do not match!";
      newPlayerScreen.info.time = MESSAGE_TIME_LONG;
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
        newPlayerScreen.info.time = MESSAGE_TIME_LONG;
        newPlayerScreen.status = 0;
        newPlayerScreen.infoList[0].input = true;
        newPlayerScreen.infoList[1].input = false;
        newPlayerScreen.infoList[2].input = false;
        newPlayerScreen.infoList[0].message = newPlayerScreen.infoList[1].message = newPlayerScreen.infoList[2].message = "";
        return;
      }    

    // save to player's own file
    s = new String [7];
    s[0] = hash(newPlayerScreen.infoList[1].message);                                          // password
    s[1] = "0 0";                                                                                    // max round , max world
    s[2] = str(DEFAULT_MONEY);
    s[3] = str(DEFAULT_HEALTH);
    s[4] = "true false false false false false";                                                    // weapon
    s[5] = "false false false false";                                                               // obj
    s[6] = "0&0&100 0&"+ str(DEFAULT_HEALTH) + "&100 0&1&100 0&1&100 0&1&100 0&1&100 0&1&100 0&0&500 0&1&150 0&0&180";  // upgrades
    saveStrings("./Player/" + newPlayerScreen.infoList[0].message + ".txt", s);

    // add player's name to playerlist
    s = loadStrings("./Player/player.txt");
    s = (String []) append(s, newPlayerScreen.infoList[0].message);
    saveStrings("./Player/player.txt", s);

    // update player list in change player screen
    player.updatePlayerList();

    // auto login and change to menu screen
    changePlayerScreen.infoList[0].message = newPlayerScreen.infoList[0].message;
    changePlayerScreen.infoList[1].message = newPlayerScreen.infoList[1].message;
    screen.changeScreen(menuScreen);
    player.loadPlayer();
  } 

  void savePlayer() {
    // do not save if player hasn't log in yet
    if (player.name == null)
      return;

    // load current data from file
    String data [] = loadStrings("./Player/" + name + ".txt");

    // copy info from game to data
    data[1] = maxWorld + " " + maxRound; 
    data[2] = str(shooter.money);
    data[3] = str(shooter.upgradeList[1].value);

    // save weapon list
    data[4] = "";
    for (int i=0; i<shooter.weaponList.length; i++) 
      data[4] += str(shooter.weaponList[i].enable) + " ";
    data[4] = data[4].substring(0, data[4].length()-1);        // remove trailing space

    // enalbe new obj
    data[5] = "";
    for (int i=0; i<shooter.objList.length; i++) 
      data[5] += str(shooter.objList[i].enable) + " ";
    data[5] = data[5].substring(0, data[5].length()-1);        // remove trailing space

    // save upgrades
    // format: value&price value&price value&price ...
    data[6] = "";
    for (int i=0; i<shooter.upgradeList.length; i++) 
      data[6] += str(shooter.upgradeList[i].level) + '&' + str(shooter.upgradeList[i].value) + '&' + str(shooter.upgradeList[i].price) + ' '; 
    data[6] = data[6].substring(0, data[6].length()-1);        // remove trailing space

    // save to file
    saveStrings("./Player/" + name + ".txt", data);

    // clear data
    newPlayerScreen.infoList[0].message = "";
    newPlayerScreen.infoList[1].message = "";
    newPlayerScreen.infoList[2].message = "";
  }

  void deletePlayer () {
    // remove name from player list
    String data [] = loadStrings("./Player/player.txt");
    for (int i=0; i<data.length; i++) 
      if (data[i].equals(name)) {
        data = (String []) concat(subset(data, 0, i), subset(data, i+1));
        saveStrings("./Player/player.txt", data);
        break;
      }

    // remove player data file
    File f = new File(sketchPath() + "/Player/" + name + ".txt");
    f.delete();

    // update player list in change player screen
    player.updatePlayerList();

    // remove other info
    player.name = null;
    screen.info.time = 0;
  }

  int login () {
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
      screen.info.time = MESSAGE_TIME_LONG;
      return 1;
    }

    // read player's file for pass
    String data [] = loadStrings("./Player/" + changePlayerScreen.infoList[0].message + ".txt");

    // if wrong pass
    if (!hash(changePlayerScreen.infoList[1].message).equals(data[0])) {
      changePlayerScreen.infoList[1].message = "";
      screen.info.message = "Wrong password!";
      screen.info.time = MESSAGE_TIME_LONG;
      return 1;
    }

    // pass is correct
    screen.changeScreen(menuScreen);
    loadPlayer();
    return 0;
  }

  void updatePlayerList() {
    // load data from file
    String data [] = loadStrings("./Player/player.txt");
    changePlayerScreen.infoList = new Info [data.length + 2];  

    // info[0]: username, info[1]: password
    changePlayerScreen.infoList[0] = new Info("", 375, 370, RED, fontMedium);
    changePlayerScreen.infoList[1] = new Info("", 375, 465, RED, fontMedium);
    changePlayerScreen.infoList[1].hiden = true;

    // all user names
    for (int i=0; i<data.length; i++) {
      changePlayerScreen.infoList[i+2] = new Info(data[i], 200 + 210 * (i / 3), 150 + (i % 3) * 50, RED, fontMedium);
    }
  }

  String hash (String stringToEncrypt) {
    try {
      MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
      messageDigest.update(stringToEncrypt.getBytes());
      return new String(messageDigest.digest());
    } 
    catch (NoSuchAlgorithmException e) {
      screen.info.message = "Error on hash the password";
      screen.info.time = MESSAGE_TIME_LONG;
      return null;
    }
  }
}
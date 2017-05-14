class Player implements java.io.Serializable {
  String name;
  int money;     // current $ of player

  int maxWorld;  // max world player can play
  int maxRound;  // max round in that world player can play  

  // weapons
  Weapon weaponList [] = new Weapon [] {
    new HandStone(), 
    new HandShuriken(), 
    new Bow(), 
    new HandGrenade(), 
    new FreezeGun(), 
    new LaserGun(), 
  };

  // upgrades
  // (float value, float increase, float maxLevel, float price, float priceIncrease, int method)
  Upgrade upgradeList [] = new Upgrade [] {
    new Upgrade(0, 1, 1, 100, 1.5, 0), //0 aim
    new Upgrade(DEFAULT_HEALTH, 50, 5, 100, 1.5, 1), //1 max health 
    new Upgrade(1, -0.15, 6, 100, 1.5, 0), //2 weapon delay
    new Upgrade(1, 0.1, 5, 100, 1.5, 0), //3 weapon speed
    new Upgrade(1, 0.2, 5, 100, 1.5, 0), //4 bonus money
    new Upgrade(1, -0.15, 3, 100, 1.5, 0), //5 special wp delay
    new Upgrade(1, -0.1, 3, 100, 1.5, 0), //6 how much special ability cost
    new Upgrade(0, 1, 8, 500, 1.5, 0), //7 bonus damage
    new Upgrade(1, 0.2, 6, 150, 1.5, 0), //8 explosion radius
    new Upgrade(0, 20, 5, 180, 1.5, 0), //9 wall extra health
  };

  // objs
  Obj objList [] = new Obj [] {
    new Wall(), 
    new BigWall(), 
    new Barrel(), 
    new ToxicBarrel(), 
  };

  Player() {
  }

  void loadPlayerInfo() {
    // ------------copy info to shooter--------//
    shooter.weaponList  = weaponList.clone();
    shooter.upgradeList = upgradeList.clone();
    shooter.objList     = objList.clone();
    shooter.maxRound = maxRound;
    shooter.maxWorld = maxWorld;
    shooter.money    = money;
    
    // ---------load info to screens-----------------//
    // load upgrade info to upgrade screens
    Upgrade upg;
    for (int i=0; i<upgradeList.length; i++) {
      upg = shooter.upgradeList[i];
      upgradeScreens[i/6].infoList[i%6+6] = new Info((int) upg.level + "/" + (int) upg.maxLevel, 330 + 470 * (i%6 / 3), 322 + (i%6 % 3) * 120, BROWN, fontMedium);
    }

    // load money to upgrade screens
    for (int i=0; i<shooter.upgradeList.length/6 + 1; i++)
      upgradeScreens[i].infoList[12].message = str(shooter.money);

    // load weapons name to weapon screens
    for (int i=0; i<shooter.weaponList.length/4 + 1; i++) 
      upgradeScreens[i + shooter.upgradeList.length/6 + 1].infoList[8].message = str(shooter.money);

    //------------------------add wellcome in menu screen----------------------------//
    menuScreen.info =  new TimeInfo ("Welcome, " + name + "!", 500, 50, RED, fontSmall, MESSAGE_TIME_FOREVER);
  }

  void createPlayer () {
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

    // create new file with player name and save new Player() object to it
    try {
      FileOutputStream outFile = new FileOutputStream(sketchPath() + "/Player/" + name + ".ser");
      ObjectOutputStream out = new ObjectOutputStream(outFile);
      out.writeObject(new Player());
      out.close();
      outFile.close();
    } catch (IOException e) {
      println("An Error occured when creating new file\nNew user has not been created");
      return;
    }

    // add player's name & password to playerlist
    // file structure: name hash(pass)
    s = loadStrings("./Player/player.txt");
    s = (String []) append(s, newPlayerScreen.infoList[0].message + " " + hash(newPlayerScreen.infoList[1].message));
    saveStrings("./Player/player.txt", s);

    // update player list in change player screen
    updatePlayerList();

    // auto login and change to menu screen
    changePlayerScreen.infoList[0].message = newPlayerScreen.infoList[0].message;
    changePlayerScreen.infoList[1].message = newPlayerScreen.infoList[1].message;
    screen.changeScreen(menuScreen);
    player.loadPlayerInfoInfo();
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
    for (int i=0; i<newObjList.length; i++) 
      data[5] += str(newObjList[i].enable) + " ";
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
    updatePlayerList();

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
      screen.info.time = 75;
      return 1;
    }

    // read player's file for pass
    String data [] = loadStrings("./Player/" + changePlayerScreen.infoList[0].message + ".txt");

    // if wrong pass
    if (hash(changePlayerScreen.infoList[1].message) != int(data[0])) {
      changePlayerScreen.infoList[1].message = "";
      screen.info.message = "Wrong password!";
      screen.info.time = 75;
      return 1;
    }

    // pass is correct
    screen.changeScreen(menuScreen);
    loadPlayerInfo();
    return 0;
  }
}
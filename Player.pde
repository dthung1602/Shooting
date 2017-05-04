class Player {
  String name;

  Player() {}

  void loadPlayer() {
    // load file
    this.name = changePlayerScreen.infoList[0].message;
    String data [] = loadStrings("./Player/" + this.name + ".txt");
    String tmp [];

    // copy info from file to game
    currentRound = int(data[1]); 
    shooter.money = int(data[2]);
    shooter.upgradeList[1].value = int(data[3]);

    // create weapon list
    tmp = split(data[4], ' ');
    for (int i=0; i<tmp.length; i++) 
      shooter.weaponList[i].enable = boolean(tmp[i]);

    // enalbe new obj buttons
    tmp = split(data[5], ' ');
    for (int i=0; i<tmp.length; i++) 
      playScreen.buttonList[i].enable = boolean(tmp[i]);
      
    // load upgrades
    // format: value&price value&price value&price ...
    tmp = split(data[6], ' ');
    String temp [];
    for (int i=0; i<tmp.length; i++) {
      temp = split(tmp[i], '&');
      shooter.upgradeList[i].value = float(temp[0]);
      shooter.upgradeList[i].price = float(temp[1]);
    }

    // add wellcome in menu screen
    menuScreen.info =  new TimeInfo ("Welcome, " + name + "!", 500, 50, BOLD_RED, fontSmall, -1);
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

    // save to player's own file
    s = new String [7];
    s[0] = str(hash(newPlayerScreen.infoList[1].message));                                          // password
    s[1] = "1";                                                                                     // current round
    s[2] = str(DEFAULT_MONEY);
    s[3] = str(DEFAULT_HEALTH);
    s[4] = "true false false false false false";                                                    // weapon
    s[5] = "false false false false";                                                               // obj
    s[6] = "0&100 "+ str(DEFAULT_HEALTH) + "&100 1&100 1&100 1&100 1&100 1&100 0&500 1&150 0&180";  // upgrades
    saveStrings("./Player/" + newPlayerScreen.infoList[0].message + ".txt", s);

    // add player's name to playerlist
    s = loadStrings("./Player/player.txt");
    s = (String []) append(s, newPlayerScreen.infoList[0].message);
    saveStrings("./Player/player.txt", s);
    
    // update player list in change player screen
    changePlayerScreen.updatePlayerList();

    // auto login and change to menu screen
    changePlayerScreen.infoList[0].message = newPlayerScreen.infoList[0].message;
    changePlayerScreen.infoList[1].message = newPlayerScreen.infoList[1].message;
    screen = menuScreen;
    surface.setSize(screen.bg.width, screen.bg.height);
    player.loadPlayer();
  } 

  void savePlayer() {
    // do not save if player hasn't log in yet
    if (player.name == null)
      return;
    
    // load current data from file
    String data [] = loadStrings("./Player/" + name + ".txt");

    // copy info from game to data
    data[1] = str(currentRound); 
    data[2] = str(shooter.money);
    data[3] = str(shooter.upgradeList[1].value);

    // save weapon list
    data[4] = "";
    for (int i=0; i<shooter.weaponList.length; i++) 
      data[4] += str(shooter.weaponList[i].enable) + " ";
    data[4] = data[4].substring(0, data[4].length()-1);        // remove trailing space

    // enalbe new obj buttons
    // >>>>buttonlis.length
    data[5] = "";
    for (int i=0; i<playScreen.buttonList.length; i++) 
      data[5] += str(playScreen.buttonList[i].enable) + " ";
    data[5] = data[5].substring(0, data[5].length()-1);        // remove trailing space

    // save upgrades
    // format: value&price value&price value&price ...
    data[6] = "";
    for (int i=0; i<shooter.upgradeList.length; i++) 
      data[6] += str(shooter.upgradeList[i].value) + '&' + str(shooter.upgradeList[i].price) + ' '; 
    data[6] = data[6].substring(0, data[6].length()-1);        // remove trailing space

    // save to file
    saveStrings("./Player/" + name + ".txt", data);
  }
  
  void deletePlayer () {
    // remove name from player list
    String data [] = loadStrings("./Player/" + name + ".txt");
    for (int i=0; i<data.length; i++)
      if (data[i].equals(name)) {
        data = (String []) concat(subset(data, 0, i), subset(data, i+1));
        break;
      }
      
    // remove player data file
    File f = new File("./Player/" + name + ".txt");
    f.delete();
      
    // update player list in change player screen
    changePlayerScreen.updatePlayerList();
  }
}
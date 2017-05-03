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
    shooter.maxHealth = int(data[3]);
    
    // create weapon list
    tmp = split(data[4], ' ');
    for (int i=0; i<tmp.length; i++) 
      shooter.weaponList[i].enable = boolean(tmp[i]);
      
    // enalbe new obj buttons
    tmp = split(data[5], ' ');
    for (int i=0; i<tmp.length; i++) 
      playScreen.buttonList[i].enable = boolean(tmp[i]);
    
    // add wellcome in menu screen
    menuScreen.info =  new TimeInfo ("Welcome, " + name + "!", 500, 50, BOLD_RED, fontSmall, -1);
  }
  
  void createPlayer () {
    String newName = changePlayerScreen.infoList[0].message;
    
    // check if username has been taken or not
    boolean taken = false;
    for (int i=2; i<changePlayerScreen.infoList.length; i++) {
      if (split(changePlayerScreen.infoList[i].message, " ")[1].equals(newName)) {
        taken = true;
        break;
      }
    }
    
    if (taken) {
      screen.info.message = "Username has been used.\nPlease choose another";
      screen.info.time = 75;
      changePlayerScreen.infoList[0].message = "";
      changePlayerScreen.infoList[1].message = "";
      changePlayerScreen.status = 0;
      return;
    }
      
    String data [] = new String [] {
      str(hash(changePlayerScreen.infoList[1].message)),                     // pass
      "1",                                 // current round
      "0",                                 // money
      "20",                                // max health default
      "true false false false false false",// weapon list: true false false ... --> enable wp in shooter.weaponList
      "false false false false false false",// obj list: true false true false...  --> enable new obj buttons in playscreen
      "//>> sth here"                      // upgrade
    };
    
    saveStrings("./Players/" + newName + ".txt", data);
    
    // auto log in to new user
    loadPlayer();
  } 
}
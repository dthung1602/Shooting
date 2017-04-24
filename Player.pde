class Player {
  String name;
  String pass;
  
  Player() {}
  
  void loadPlayer() {
    // load file
    this.name = changeUserScreen.infoList[0].message;
    String data [] = loadStrings("./Player/" + this.name + ".txt");
    String tmp [];
    
    // copy info from file to game
    currentRound = int(data[1]); 
    shooter.money = int(data[2]);
    shooter.maxHealth = int(data[3]);
    
    // create weapon list
    tmp = split(data[4], ' ');
    for (int i=0; i<tmp.length; i++) 
      shooter.weaponList = (Weapon []) append(shooter.weaponList, typeOfWeapon(int(tmp[i])));
      
    // enalbe new obj buttons
    tmp = split(data[5], ' ');
    for (int i=0; i<tmp.length; i++) 
      playScreen.buttonList[i].enable = boolean(tmp[i]);
  }
  
  void createPlayer () {
    String data [] = new String [] {
      str(hash(pass)),                     // pass
      "1",                                 // current round
      "0",                                 // money
      "20",                                // max health default
      "0",                                 // weapon list: 0 = hand stone, 1 = hand shuriken, ...
      "false false false false false",     // obj list: true false true false...  --> enable new obj buttons in playscreen
      "//>> sth here"                      // upgrade
    };
    
    saveStrings("./Players/" + name + ".txt", data);
  }
  
  private int typeOfWeapon (Weapon wp) {
    if (wp instanceof HandStone)
      return 0;
    if (wp instanceof HandShuriken)
      return 1;
    if (wp instanceof Bow)
      return 2;
    if (wp instanceof HandGrenade)
      return 3;
    if (wp instanceof FreezeGun)
      return 4;
    return 5; // lasergun
  }
  
  private Weapon typeOfWeapon (int k) {
    switch (k) {
      case 0: return new HandStone();
      case 1: return new HandShuriken();
      case 2: return new Bow();
      case 3: return new HandGrenade();
      case 4: return new FreezeGun();
      default: return new LaserGun();
    }
  }  
}
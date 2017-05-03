abstract class Button {
  int x1, y1;                      // upper left corner
  int x2, y2;                      // lower right corner
  boolean enable = true;

  Button(int x1, int y1, int x2, int y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }

  boolean containPoint(float x, float y) {
    if (x1<=x && x<x2 && y1<y && y<y2)
      return true;
    return false;
  }

  void action() {}
}

// -----------------------New obj------------------------
class NewObjButton extends Button {
  int objNum;
  
  NewObjButton (int x1, int y1, int x2, int y2, int objNum) {
    super(x1, y1, x2, y2);
    this.objNum = objNum;
  }
  
  void action () {
    shooter.currentObj = newObj();
  }
  
  private Obj newObj () {
    switch (objNum) {
      case 0: return new Wall (mouseX, mouseY);
      case 1: return new BigWall (mouseX, mouseY);
      case 2: return new Barrel (mouseX, mouseY);
      default: return new ToxicBarrel (mouseX, mouseY);
    }
  }
}



//------------------------menu button----------------------
class ContinueButton extends Button {
  ContinueButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
    // ask player to log in
    if (player.name == null) {
      screen.info.message = "Please login!";
      screen.info.time = 75;
      return;
    }
    
    screen = playScreen;
    surface.setSize(screen.bg.width, screen.bg.height);
    resetRound();
  }
}

class UpGradeButton extends Button {
  UpGradeButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
    screen = upgradeScreen;
    surface.setSize(screen.bg.width, screen.bg.height);
  }
}

class DataButton extends Button {
  DataButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
    screen = dataScreen;
    surface.setSize(screen.bg.width, screen.bg.height);
  }
}

class ChangePlayerButton extends Button {
  ChangePlayerButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
    screen = changePlayerScreen;
    surface.setSize(screen.bg.width, screen.bg.height);
  }
}

class NewPlayerButton extends Button {
  NewPlayerButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
    screen = newPlayerScreen;
    surface.setSize(screen.bg.width, screen.bg.height);
  }
}

/*class HighScoreButton extends Button {
  HighScoreButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
    screen = highScoreScreen;
    surface.setSize(screen.bg.width, screen.bg.height);
  }
}*/

class SettingButton extends Button {
  SettingButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
    screen = settingScreen;
    surface.setSize(screen.bg.width, screen.bg.height);
  }
}

class QuitButton extends Button {
  QuitButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
    exit();
  }
}


//--------------------play screen buttons--------------
class MenuButton extends Button {  
  MenuButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
    screen = menuScreen;
    surface.setSize(screen.bg.width, screen.bg.height);
  }
}

class ChoosingRoundMenuButton extends Button {
  ChoosingRoundMenuButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }
  
  void action() {
    screen = choosingRoundScreen;
    surface.setSize(screen.bg.width, screen.bg.height);
  }
}


//-------------sound buttons-------------------
class MusicButton extends Button {
  MusicButton (int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }
  
  void action () {
    if (musicEnable) {
      screen.info.message = "Music disabled";
      screen.info.time = 50;
    } else {
      screen.info.message = "Music enabled";
      screen.info.time = 50;
    }
    musicEnable = !musicEnable;
  }
}


class SoundButton extends Button {
  SoundButton (int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }
  
  void action () {
    if (soundEnable) {
      screen.info.message = "Sound effect disabled";
      screen.info.time = 50;
    } else {
      screen.info.message = "Sound effect enabled";
      screen.info.time = 50;
    }
    soundEnable = !soundEnable;
  }
}

//----------------------buttons in other menu---------------------
class IncreaseUpgadeButton extends Button {
  int mode;
  
  IncreaseUpgadeButton (int x1, int y1, int x2, int y2, int mode) {
    super(x1, y1, x2, y2);
    this.mode = mode;
  }
  
  void action () {
    //----------mode 0: aim-------------------------
    if (mode == 0) {
      if (shooter.aim)
        alreadyBought();
      else if (shooter.money < 100)
        notEnough();
      else
        shooter.aim = true;        
    }
    
    //--------- mode 1-->9: buy weapon--------------
    if (1 <= mode && mode <= 9) {
      //skip if already bought
      if (shooter.weaponList[mode-1].enable) {
        alreadyBought();
        return;
      }        
      
      // save price of all weapon
      int weaponPrice [] = new int [] {200, 300, 400, 500, 600, 700};
    
      // check if enough money
      if (shooter.money < weaponPrice[mode-1]) {
        notEnough();
        return;
      }
      
      // buy weapon
      shooter.money -= weaponPrice[mode-1];
      shooter.weaponList[mode-1].enable = true;
      return;
    }
   
    /*
    float uWeaponDelay = 1;        // * how long before weapon can shoot again
  float uWeaponSpeed = 1;        // * how fast bullet is
  float uBonusMoney  = 1;        // * how much more money / an enemy
  float uSpecialWeaponDelay = 1; // * how long before weapon can use it special ability
  float uSpecialPrice = 1;       // * how much special ability cost 
  float uBonusDamage = 0;        // + how much extra damage bullet cause
  float uExplodeRadius = 1;      // * how large explosion radius is
  int uWallExtraHealth = 0;      // + wall extra health
    */
    
    //-----------------mode >= 10: others upgrades-------------------
    //if (mode == 11)
  }
  
  private void alreadyBought() {
    screen.info.message = "Already bought!";
    screen.info.time = 75;
  }
  
  private void notEnough() {
    screen.info.message = "Not enough money!";
    screen.info.time = 75;
  }
}
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

  void action() {
  }
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
    case 0: 
      return new Wall (mouseX, mouseY);
    case 1: 
      return new BigWall (mouseX, mouseY);
    case 2: 
      return new Barrel (mouseX, mouseY);
    default: 
      return new ToxicBarrel (mouseX, mouseY);
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

class UpGradeScreenButton extends Button {
  UpGradeScreenButton(int x1, int y1, int x2, int y2) {
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
    changePlayerScreen.infoList[0].input = true;
    changePlayerScreen.infoList[1].input = false;
  }
}

class NewPlayerButton extends Button {
  NewPlayerButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
    screen = newPlayerScreen;
    surface.setSize(screen.bg.width, screen.bg.height);
    newPlayerScreen.infoList[0].input = true;
    newPlayerScreen.infoList[1].input = false;
    newPlayerScreen.infoList[2].input = false;
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

class QuitScreenButton extends Button {
  QuitScreenButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
    screen = quitScreen;
  }
}

class QuitButton extends Button {
  QuitButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
    player.savePlayer();
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
    musicEnable = !musicEnable;
  }
}


class SoundButton extends Button {
  SoundButton (int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action () {
    soundEnable = !soundEnable;
  }
}


class LoginButton extends Button {
  LoginButton (int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action () {
    login();
  }
}


class TextFieldButton extends Button {
  int fieldNum;

  TextFieldButton (int x1, int y1, int x2, int y2, int fieldNum) {
    super(x1, y1, x2, y2);
    this.fieldNum = fieldNum;
  }

  void action () {
    screen.infoList[screen.status].input = false;
    screen.status = fieldNum;
    screen.infoList[screen.status].input = true;
  }
}


class ResumeButton extends Button {
  int feildNum;

  ResumeButton (int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action () {
    screen = playScreen;
    surface.setSize(screen.bg.width, screen.bg.height);
  }
}


class CreateNewUserButton extends Button {
  CreateNewUserButton (int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action () {
    player.createPlayer();
  }
}


class BuyWeaponButton extends Button {
  int wpNum;

  BuyWeaponButton (int x1, int y1, int x2, int y2, int wpNum) {
    super(x1, y1, x2, y2);
    this.wpNum = wpNum;
  }

  void action () {
    //skip if already bought
    if (shooter.weaponList[wpNum].enable) {
      screen.info.message = "Already bought!";
      screen.info.time = 75;
      return;
    }        

    // >> save price of all weapon
    int weaponPrice [] = new int [] {200, 300, 400, 500, 600, 700};

    // check if enough money
    if (shooter.money < weaponPrice[wpNum]) {
      screen.info.message = "Not enough money!";
      screen.info.time = 75;
      return;
    }

    // buy weapon
    shooter.money -= weaponPrice[wpNum];
    shooter.weaponList[wpNum].enable = true;
    return;
  }
}


class UpgradeButton extends Button {
  int ugNum;

  UpgradeButton (int x1, int y1, int x2, int y2, int ugNum) {
    super(x1, y1, x2, y2);
    this.ugNum = ugNum;
  }

  void action () {
    shooter.upgradeList[ugNum].upgrade();
  }
}

class DowngradeButton extends Button {
  int ugNum;

  DowngradeButton (int x1, int y1, int x2, int y2, int ugNum) {
    super(x1, y1, x2, y2);
    this.ugNum = ugNum;
  }

  void action () {
    shooter.upgradeList[ugNum].downgrade();
  }
}


class MapButton extends Button {
  MapButton (int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action () {
    screen = choosingRoundScreen;
    surface.setSize(screen.bg.width, screen.bg.height);
  }
}


class BuyScreenButton extends Button {
  BuyScreenButton (int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action () {
    screen = buyScreen;
    surface.setSize(screen.bg.width, screen.bg.height);
  }
}
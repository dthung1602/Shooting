abstract class Button {
  int x1, y1;                      // upper left corner
  int x2, y2;                      // lower right corner
  boolean enable = true;
  boolean circle = false;
  boolean highlight = true;

  Button(int x1, int y1, int x2, int y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }

  void show() {
    if (!highlight) 
      return;
    noStroke();
    fill(CLEAR_BLUE);
    if (circle) {
      ellipse(x1, y1, x2, y2);
    } else {
      rect(x1, y1, x2, y2);
    }
  }

  boolean containPoint(float x, float y) {
    if (x1<=x && x<x2 && y1<y && y<y2)
      return true;
    return false;
  }

  void action() {
  }
}


//---------------------------chage screen-----------------------------------------
class ChangeScreenButton extends Button {
  int screenNum;
  

  ChangeScreenButton (int x1, int y1, int x2, int y2, int screenNum) {
    super(x1, y1, x2, y2);
    this.screenNum = screenNum;
  }

  void action () {
    screen.changeScreen(screenList[screenNum]);
  }
}


//----------------------menu screen----------------------
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

    screen.changeScreen(playScreen);
    resetRound();
  }
}


// -----------------------Play screen------------------------
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


// -----------------------Upgrades-------------------------------------
class UpgradeScreenButton extends Button {
  int num;

  UpgradeScreenButton(int x1, int y1, int x2, int y2, int num) {
    super(x1, y1, x2, y2);
    this.num = num;
  }

  void action() {
    screen.changeScreen(upgradeScreens[num]);
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

    // price of weapon
    int price = weaponType(wpNum).price;

    // check if enough money
    if (shooter.money < price) {
      screen.info.message = "Not enough money!";
      screen.info.time = 75;
      return;
    }

    // buy weapon
    shooter.money -= price;
    shooter.weaponList[wpNum].enable = true;
  }
}


class BuyBulletButton extends Button {
  int wpNum;

  BuyBulletButton (int x1, int y1, int x2, int y2, int wpNum) {
    super(x1, y1, x2, y2);
    this.wpNum = wpNum;
  }

  void action () {
    // price of weapon
    int price = weaponType(wpNum).bullet.price;

    // check if enough money
    if (shooter.money < price) {
      screen.info.message = "Not enough money!";
      screen.info.time = 75;
      return;
    }

    // buy bullet
    shooter.money -= price;
    shooter.weaponList[wpNum].bulletLeft += 1;
  }
}


class UpgradeButton extends Button {
  int ugNum;

  UpgradeButton (int x1, int y1, int x2, int y2, int ugNum) {
    super(x1, y1, x2, y2);
    this.ugNum = ugNum;
  }

  void action () {
    shooter.upgradeList[ugNum].upgrade(ugNum);
  }
}

class DowngradeButton extends Button {
  int dgNum;

  DowngradeButton (int x1, int y1, int x2, int y2, int dgNum) {
    super(x1, y1, x2, y2);
    this.dgNum = dgNum;
  }

  void action () {
    shooter.upgradeList[dgNum].downgrade(dgNum);
  }
}


//--------------------------player screens--------------------------
class ChangePlayerButton extends Button {
  ChangePlayerButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
    screen.changeScreen(changePlayerScreen);
    changePlayerScreen.infoList[0].input = true;
    changePlayerScreen.infoList[1].input = false;
  }
}


class NewPlayerButton extends Button {
  NewPlayerButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
    screen.changeScreen(newPlayerScreen);
    newPlayerScreen.infoList[0].input = true;
    newPlayerScreen.infoList[1].input = false;
    newPlayerScreen.infoList[2].input = false;
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


class LoginButton extends Button {
  LoginButton (int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action () {
    player.login();
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


class DeletePlayerButton extends Button {
  DeletePlayerButton (int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action () {
    if (player.login() == 0)
      player.deletePlayer();
  }
}


//-----------------------------setting buttons---------------------------------
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


//------------------------Other buttons---------------------------------
class QuitButton extends Button {
  QuitButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
    player.savePlayer();
    exit();
  }
}
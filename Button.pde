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


//--------------------------------------chage screen-----------------------------------------
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


//---------------------------------------menu screen----------------------------------------
class ContinueButton extends Button {
  ContinueButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
    // ask player to log in
    if (player.name == null) {
      screen.info.message = "Please login!";
      screen.info.time = MESSAGE_TIME_LONG;
      return;
    }

    // update bars max values
    playScreen.updateBars();

    screen.changeScreen(playScreen);
    round.reset();
  }
}


//---------------------------------------Upgrades---------------------------------------
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
      screen.info.time = MESSAGE_TIME_SHORT;
      return;
    }        

    // price of weapon
    int price = shooter.weaponList[wpNum].price;

    // check if enough money
    if (shooter.money < price) {
      screen.info.message = "Not enough money!";
      screen.info.time = MESSAGE_TIME_SHORT;
      return;
    }

    // buy weapon
    shooter.money -= price;
    shooter.weaponList[wpNum].enable = true;
    
    // update info
    upgradeScreens[0].infoList[12].message = str(shooter.money);
    upgradeScreens[1].infoList[12].message = str(shooter.money);
    upgradeScreens[2].infoList[8].message = str(shooter.money);
    upgradeScreens[3].infoList[8].message = str(shooter.money);
  }
  
  void show() {
    super.show();
    screen.infoList[9].message = shooter.weaponList[wpNum].explaination;   // explain wp
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
    int price = shooter.weaponList[wpNum].bullet.price;

    // check if enough money
    if (shooter.money < price) {
      screen.info.message = "Not enough money!";
      screen.info.time = MESSAGE_TIME_SHORT;
      return;
    }

    // buy bullet
    shooter.money -= price;
    shooter.weaponList[wpNum].bulletLeft += 1;
    
    // update explaination
    shooter.weaponList[wpNum].explaination =  split(shooter.weaponList[wpNum].explaination, "\nBullet left: ")[0] + "\nBullet left: " + shooter.weaponList[wpNum].bulletLeft;
    
    // update money
    upgradeScreens[0].infoList[12].message = str(shooter.money);
    upgradeScreens[1].infoList[12].message = str(shooter.money);
    upgradeScreens[2].infoList[8].message = str(shooter.money);
    upgradeScreens[3].infoList[8].message = str(shooter.money);
  }
  
  void show() {
    super.show();
    screen.infoList[9].message = shooter.weaponList[wpNum].explaination;   // explain wp
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
  
  void show() {
    super.show();
    screen.infoList[13].message = shooter.upgradeList[ugNum].explaination;  // explain upgrade
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
  
  void show() {
    super.show();
    screen.infoList[13].message = shooter.upgradeList[dgNum].explaination;  // explain upgrade
  }
}


//---------------------------------------player screens---------------------------------------
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


//---------------------------------------setting buttons---------------------------------------
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


//---------------------------------------Map screen buttons---------------------------------------
class MapScreenButton extends Button {
  int num;

  MapScreenButton(int x1, int y1, int x2, int y2, int num) {
    super(x1, y1, x2, y2);
    this.num = num;
  }

  void action() {
    // ask player to log in
    if (player.name == null) {
      screen.info.message = "Please login!";
      screen.info.time = MESSAGE_TIME_SHORT;
      return;
    }
    
    screen.changeScreen(mapScreens[num]);
  }
}


class ChooseWorldButton extends Button {
  int worldNum;
  
  ChooseWorldButton(int x1, int y1, int x2, int y2, int worldNum) {
    super(x1, y1, x2, y2);
    this.worldNum = worldNum;
  }
  
  void action () {
    // check if world is unlocked
    if (worldNum > player.maxWorld) {
      screen.info.message = "World is not unlocked yet!";
      screen.info.time = MESSAGE_TIME_SHORT;
      return;
    }
      
    // change to choose round screen
    round.currentWorld = worldNum;
    screen.changeScreen(chooseRoundScreen);
  }
}


class ChooseRoundButton extends Button {
  int roundNum;
  
  ChooseRoundButton(int x1, int y1, int x2, int y2, int roundNum) {
    super(x1, y1, x2, y2);
    this.roundNum = roundNum;
  }
  
  void action () {
    // check if round is unlocked
    if (roundNum > player.maxRound && round.currentWorld == player.maxWorld) {
      screen.info.message = "Round is not unlocked yet!";
      screen.info.time = MESSAGE_TIME_SHORT;
      return;
    }
    
    // update bars max values
    playScreen.updateBars();
    
    round.currentRound = roundNum;
    round.reset();
    screen.changeScreen(playScreen);
  }
}


//---------------------------------------Other buttons---------------------------------------
class QuitButton extends Button {
  QuitButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
    player.savePlayer();
    exit();
  }
}
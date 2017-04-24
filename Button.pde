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
  }
}

class UpGradeButton extends Button {
  UpGradeButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
  }
}

class ChangePlayerButton extends Button {
  ChangePlayerButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
  }
}

class HighScoreButton extends Button {
  HighScoreButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
  }
}

class SettingButton extends Button {
  SettingButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
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
  }
}

class ResumeButton extends Button {
  ResumeButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
    screen = playScreen;
  } 
}

class ChoosingRoundMenuButton extends Button {
  ChoosingRoundMenuButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }
  
  void action() {
    screen = choosingRoundScreen;
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

class NewPlayerButton extends Button {
  NewPlayerButton (int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }
  
  void action () {
    player.createPlayer();
  }
}
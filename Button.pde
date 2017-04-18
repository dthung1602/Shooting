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
class NewWallButton extends Button {
  NewWallButton (int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }
  
  void action () {
    shooter.currentObj = new Wall(mouseX, mouseY);
  }
}


class NewBigWallButton extends Button {
  NewBigWallButton (int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }
  
  void action () {
    shooter.currentObj = new BigWall(mouseX, mouseY);
  }
}


class NewBarrel extends Button {
  NewBarrel (int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }
  
  void action () {
    shooter.currentObj = new Barrel(mouseX, mouseY);
  }
}


class NewToxicBarrel extends Button {
  NewToxicBarrel (int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }
  
  void action () {
    shooter.currentObj = new Barrel(mouseX, mouseY);
  }
}


//-------------------------------------------------------

class HighScoreButton extends Button {
  HighScoreButton(int x1, int y1, int x2, int y2) {
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

class MenuButton extends Button {  
  MenuButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
    screen = menuScreen;
  }
}

class ChooseRoundButton extends Button { 
  ChooseRoundButton(int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
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
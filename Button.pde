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

// tmp
class NewWallButton extends Button {
  NewWallButton (int x1, int y1, int x2, int y2) {
    super(x1, y1, x2, y2);
  }
  
  void action () {
    shooter.currentStuff = new ExWall(mouseX, mouseY);
  }
}
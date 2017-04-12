abstract class Button {
  float x1, y1;                      // upper left corner
  float x2, y2;                      // lower right corner
  boolean enable = true;

  Button(float x1, float y1, float x2, float y2) {
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
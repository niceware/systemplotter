class HyperLink {
  PVector pos;
  color unclicked, clicked, old;
  String displayText, uRL;
  float texWid, texHei;
  private int timeDown;
  boolean once;

  HyperLink(String d, String u) {
    this(d, u, 10, 10);
  }
  HyperLink(String d, String u, float x, float y) {
    pos = new PVector(x, y);
    displayText = d;
    uRL = u;

    unclicked = #0000ee;
    clicked = #ee0000;
    old = #551a8b;
    timeDown = 0;
    texWid = textWidth(displayText)*5/6;
    texHei = 8;
    once = false;
  }

  void display() {
    checkClicked();
    fill(pickColor());
    text(displayText, pos.x, pos.y);
    stroke(pickColor());
    line(pos.x, pos.y+1, pos.x+texWid, pos.y+1);

    timeDown--;
  }

  void checkClicked() {
    if (mouseX > pos.x && mouseX < pos.x+texWid && mouseY > pos.y-texHei && mouseY < pos.y) {
    cursor(HAND);
      if (mousePressed && timeDown <= 0) {
        link(uRL);
        once = true;
        timeDown = 10;
      }
    } else cursor(ARROW);
  }

  color pickColor() {
    if (timeDown > 0) return clicked;
    else if (once) return old;
    else return unclicked;
  }
}
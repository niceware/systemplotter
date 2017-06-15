class StepBox extends ClickBox {
  boolean arrows;
  StepBox() {
    this(10, 10);
  }
  StepBox(float x, float y) {
    this(x, y, 10, 10, false);
  }
  StepBox(float x, float y, float w, float h, boolean a) {
    pos = new PVector(x, y);
    boxWid = w;
    boxHei = h;

    arrows = a;
    clicked = false;
    stillClicked = false;
    ticked = false;
  }

  void display() {
    checkClicked();
    stroke(#000000);

    if (ticked) fill(#aaffaa);
    else fill(#ffffff);
    rect(pos.x, pos.y, boxWid, boxHei);
    if (arrows) {
      line(pos.x+(boxWid/4), pos.y, pos.x+(boxWid/2), pos.y+(boxHei/2));
      line(pos.x+(boxWid/2), pos.y+(boxHei/2), pos.x+(boxWid/4), pos.y+boxHei);
      line(pos.x+(boxWid/2), pos.y, pos.x+(boxWid*3/4), pos.y+(boxHei/2));
      line(pos.x+(boxWid*3/4), pos.y+(boxHei/2), pos.x+(boxWid/2), pos.y+boxHei);
    }
  }

  void endStep() {
    if (ticked) ticked = false;
  }
}
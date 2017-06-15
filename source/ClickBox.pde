class ClickBox {
  PVector pos;
  float boxWid, boxHei;
  boolean clicked, stillClicked, ticked;
  
  ClickBox() {
    this(10, 10);
  }
  ClickBox(float x, float y) {
    this(x, y, 10, 10);
  }
  ClickBox(float x, float y, float w, float h) {
    pos = new PVector(x, y);
    boxWid = w;
    boxHei = h;
    
    clicked = false;
    stillClicked = false;
    ticked = false;
  }
  
  void display() {
    checkClicked();
    stroke(#000000);
    fill(#ffffff);
    rect(pos.x, pos.y, boxWid, boxHei);
    if (ticked) {
      stroke(#445544);
      line(pos.x+(boxWid/4), pos.y+(boxHei/2), pos.x+(boxWid/2), pos.y+boxHei);
      line(pos.x+(boxWid/2), pos.y+boxHei, pos.x+boxWid+2, pos.y-2);
    }
  }
  
  void checkClicked() {
      if (mouseX > pos.x && mouseX < pos.x+boxWid && mouseY > pos.y && mouseY < pos.y+boxHei && mousePressed) clicked = true;
      else clicked = false;
    if (clicked && !stillClicked) {
      ticked = !ticked;
      stillClicked = true;
    } else if (!clicked && stillClicked) stillClicked = false;
  }
}
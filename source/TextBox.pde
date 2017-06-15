class TextBox extends ClickBox {
  String value;
  float numVal;
  char lastCh;
  boolean clear;

  TextBox() {
    this(10, 10);
  }
  TextBox(float x, float y) {
    pos = new PVector(x, y);

    clear = false;
    boxWid = 26;
    boxHei = 16;
    lastCh = ' ';
    value = "1";
  }

  void display() {
    checkClicked();
    type();
    stroke(#000000);
    if (clicked) fill(#eeeeee);
    else fill(#ffffff);
    rect(pos.x, pos.y, boxWid, boxHei);
    String tempStr = "";
    if (value.length() > 3) tempStr = value.substring(value.length()-3, value.length());
    else tempStr = value;
    fill(#000000);
    text(tempStr, pos.x+4, pos.y+13);
  }
  
  void checkClicked() {
    if (mousePressed) {
      if (mouseX > pos.x && mouseX < pos.x+boxWid && mouseY > pos.y && mouseY < pos.y+boxHei) clicked = true;
      else clicked = false;
    }
  }

  void type() {
    if (clicked) {
      if (!clear) {
        if (key != 8 && key != 9 && key != 10 && key != 32) { //tab, space, enter
          if (keyPressed && lastCh != key) {
            value += key;
            lastCh = key;
          }
        } else clear = true;
      } else {
        value = "";
        lastCh = ' ';
        clear = false;
      }
    } else lastCh = ' ';
  }

  float getNum() {
    try {
      if (value.length() > 3) numVal =  Float.parseFloat(value.substring(value.length()-3, value.length()));
      else numVal = Float.parseFloat(value);
    } catch (NumberFormatException e) {}
    return numVal;
  }
}
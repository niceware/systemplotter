Grid grid;
ArrayList<Point> points = new ArrayList<Point>();
ClickBox steps, drag;
StepBox conti, rando, placer;
TextBox coBox[], stsiBox, rCountBox, placeBox[];
HyperLink name;

final int VG = 500, HG = 500;
final PVector eqUIpos = new PVector(40, 45);
color bg, gridlines, midgrid;
float coVal[], stepSize;
int mousX, mousY, spaceUI, rCount, placePos[];


void setup() {
  size(600, 400);
  frameRate(60);
  colorMode(HSB, 180, 100, 100, 100);
  ellipseMode(CENTER);

  setVars();
}

void draw() {
  background(bg);

  varStep();
  showPoints();
  cleanUp();
  showUI();

  println(frameRate);
}

void mouseDragged() {
  if (drag.ticked) {
    if (grid.get(mousX, mousY) != null) points.add(new Point(grid, mousX, mousY, (int)(3/stepSize)));
  }
}

void mouseClicked() {
  if (!drag.ticked) {
    if (grid.get(mousX, mousY) != null) points.add(new Point(grid, mousX, mousY, (int)(3/stepSize)));
  }
}

void setVars() {
  mousX = 0;
  mousY = 0;
  spaceUI = 200;
  placePos = new int[2];
  stepSize = .1;
  coVal = new float[4];
  for (int i = 0; i < coVal.length; i++) coVal[i] = 1;

  bg = color(#dddddd);
  gridlines = color(#999999);
  midgrid = color(#555555);

  grid = new Grid(VG, HG, spaceUI, bg, gridlines, midgrid);
  steps = new ClickBox(eqUIpos.x-24, eqUIpos.y+70);
  drag = new ClickBox(eqUIpos.x-24, eqUIpos.y+85);
  conti = new StepBox(eqUIpos.x+50, eqUIpos.y+70, 14, 10, true);
  rando = new StepBox(eqUIpos.x-24, eqUIpos.y+105);
  placer = new StepBox(eqUIpos.x-24, eqUIpos.y+125);
  coBox = new TextBox[4];
  coBox[0] = new TextBox(eqUIpos.x, eqUIpos.y);
  coBox[1] = new TextBox(eqUIpos.x+50, eqUIpos.y);
  coBox[2] = new TextBox(eqUIpos.x, eqUIpos.y+20);
  coBox[3] = new TextBox(eqUIpos.x+50, eqUIpos.y+20);
  placeBox = new TextBox[2];
  placeBox[0] = new TextBox(eqUIpos.x+72, eqUIpos.y+120);
  placeBox[1] = new TextBox(eqUIpos.x+112, eqUIpos.y+120);
  stsiBox = new TextBox(eqUIpos.x+35, eqUIpos.y+40);
  stsiBox.value = Float.toString(stepSize);
  rCountBox = new TextBox(eqUIpos.x+24, eqUIpos.y+100);
  name = new HyperLink("brianna reilly", "http://www.processing.org", 120, height-12);
}

void varStep() {
  mousX = (int)map(mouseX, spaceUI, width, -VG/2, VG/2);
  mousY = (int)map(mouseY, 0, height, HG/2, -HG/2);

  if ((millis() % 100 < 15 && steps.ticked) || conti.ticked) {
    for (int i = 0; i < points.size(); i++) {
      Point temp = points.get(i);
      temp.d.x = getD(temp.truePos.x, temp.truePos.y, true);
      temp.d.y = getD(temp.truePos.x, temp.truePos.y, false);
      temp.incre(temp.d.x, temp.d.y);
      temp.update();
    }
    conti.endStep();
  }
  if (rando.ticked) {
    for (int i = 0; i < rCount; i++) points.add(new Point(grid, (int)random(-VG/2, VG/2), (int)random(-HG/2, HG/2), (int)(3/stepSize)));
    rando.endStep();
  }
  if (placer.ticked) {
    points.add(new Point(grid, placePos[0], placePos[1], (int)(3/stepSize)));
    placer.endStep();
  }
}

void showPoints() {
  grid.display();
  for (Point p : points) {
    p.display();
  }
}

void cleanUp() {
  for (int i = points.size()-1; i >= 0; i--) {
    int teml = points.get(i).prev.length-1;
    PVector temm[] = {points.get(i).pos, points.get(i).prev[teml/4], points.get(i).prev[teml/2], points.get(i).prev[teml*3/4], points.get(i).prev[teml]};
    if (temm[0] == null && temm[1] == null && temm[2] == null && temm[3] == null && temm[4] == null) points.remove(i);
  }
}

void showUI() {
  fill(#000000);
  text("mouse "+((mousX > -VG/2)?("@ "+mousX+", "+mousY):"not on graph"), 10, 20);
  text(points.size()+" points being tracked", 10, 32);
  
  for (int i = 0; i < coBox.length; i++) {
    coBox[i].display();
    coVal[i] = coBox[i].getNum();
    if (i < placeBox.length) {
      placeBox[i].display();
      placePos[i] = (int)placeBox[i].getNum();
    }
  }
  stsiBox.display();
  stepSize = stsiBox.getNum();
  rCountBox.display();
  rCount = (int)rCountBox.getNum();
  steps.display();
  drag.display();
  conti.display();
  rando.display();
  placer.display();
  fill(#000000);
  text("x' =           x +          y", eqUIpos.x-24, eqUIpos.y+13);
  text("y' =           x +          y", eqUIpos.x-24, eqUIpos.y+33);
  text("step size:", eqUIpos.x-20, eqUIpos.y+54);
  text("auto-step", eqUIpos.x-9, eqUIpos.y+79);
  text("drag to place", eqUIpos.x-9, eqUIpos.y+94);
  text("place           random point"+((rCount > 1)?"s":""), eqUIpos.x-9, eqUIpos.y+114);
  text("place point at (         ,           )", eqUIpos.x-9, eqUIpos.y+134);
  
  text("systems of equations plotter", 40, height-24);
  text("by", 104, height-12);
  name.display();
}

float getD(float x, float y, boolean isX) {
  if (isX) return ((coVal[0] * x) + (coVal[1] * y)) * stepSize;
  else return ((coVal[2] * x) + (coVal[3] * y)) * stepSize;
}
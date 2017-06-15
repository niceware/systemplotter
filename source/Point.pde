class Point {
  Grid base;
  PVector truePos, pos, prev[], d;
  color fill, outline;
  int rad;
  private boolean trailing;

  Point(Grid g) {
    this(g, 0, 0);
  }
  Point(Grid g, PVector p) {
    this(g, p.x, p.y);
  }
  Point(Grid g, float x, float y) {
    this(g, x, y, 0);
  }
  Point(Grid g, PVector p, int prv) {
    this(g, p.x, p.y, prv);
  }
  Point(Grid g, float x, float y, int prv) {
    rad = 8;
    truePos = new PVector(x, y);
    fill = color(random(180), 70, 100);
    outline = color(hue(fill), 100, 70);

    if (prv > 0) {
      trailing = true;
      prev = new PVector[prv];
      for (int i = 0; i < prev.length; i++) {
        prev[i] = pos;
      }
    } else trailing = false;

    base = g;
    pos = base.get((int)x, (int)y);
    d = new PVector(1, 1);
  }

  void update() {
    if (trailing) {
      for (int i = prev.length-1; i > 0; i--) {
        prev[i] = prev[i-1];
      }
      if (pos != null) prev[0] = new PVector(pos.x, pos.y);
      else prev[0] = null;
    }
  }

  void display() {
    if (trailing) {
      for (int i = prev.length-1; i > 0; i--) {
        color tempOut = color(hue(outline), saturation(outline), brightness(outline), map(i, 0, prev.length, 100, 0));
        stroke(tempOut);
        if (prev[i] != null && prev[i-1] != null) line(prev[i].x, prev[i].y, prev[i-1].x, prev[i-1].y); 
      }
    }
    fill(fill);
    stroke(outline);
    if (pos != null) ellipse(pos.x, pos.y, rad, rad);
  }

  void incre(float xx, float yy) {
    truePos.add(xx, yy);
    pos = base.get((int)truePos.x, (int)truePos.y);
  }

  boolean isTrailing() {
    return trailing;
  }
}
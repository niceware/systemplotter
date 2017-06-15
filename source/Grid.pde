class Grid {
  int vert, horiz, disp;
  float wid, hei;
  color defaults[];
  PVector pos[][], scale;

  Grid() {
    this(10, 10, 200);
  }
  Grid(int v, int h, int d) {
    this(v, h, d, color(#bbbbbb), color(#555555), color(#880000));
  }
  Grid(int v, int h, int d, color c1, color c2, color c3) {
    vert = v;
    horiz = h;
    disp = d;
    wid = width - disp - 1;
    hei = height - 1;
    scale = new PVector(vert/50, horiz/50);;

    defaults = new color[3];
    defaults[0] = c1;
    defaults[1] = c2;
    defaults[2] = c3;

    pos = new PVector[vert+1][horiz+1];
    for (int i = 0; i <= vert; i++) {
      for (int j = 0; j <= horiz; j++) {
        pos[i][j] = new PVector(disp+(wid*i)/vert, (hei*j)/horiz);
      }
    }
  }

  void display() {
    stroke(defaults[1]);
    for (int i = 0; i <= vert; i+=scale.x) 
      line(disp+(wid*i)/vert, 0, disp+(wid*i)/vert, hei);
    for (int i = 0; i <= horiz; i+=scale.y) 
      line(disp, (hei*i)/horiz, disp+wid, (hei*i)/horiz);

    stroke(defaults[2]);
    line(disp, hei/2, disp+wid, hei/2);
    line(disp+wid/2, 0, disp+wid/2, hei);
  }
  
  float get(int x, int y, boolean ifX) {
    int newx = (vert/2) + x;
    int newy = (horiz/2) - y;
    
    if (ifX) return pos[newx][newy].x;
    else return pos[newx][newy].y;
  }
  
  PVector get(int x, int y) {
    int newx = (vert/2) + x;
    int newy = (horiz/2) - y;
    //if (newx > vert) newx = vert;
    //if (newy > horiz) newy = horiz;
    //if (newx < 0) newx = 0;
    //if (newy < 0) newy = 0;
    if (newx > vert || newx < 0 || newy > horiz || newy < 0) return null;
    
    return pos[newx][newy];
  }
}
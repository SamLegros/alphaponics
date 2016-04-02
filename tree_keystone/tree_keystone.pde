import deadpixel.keystone.*;

Keystone ks;
CornerPinSurface calgarySurface;
PGraphics calgaryScreen;

Table[] calgaryTables;

float theta;
int animationCounter;
int tableSwitch;

void setup() {
  size(800, 600, P3D);
  background(255);

  ks = new Keystone(this);
  calgarySurface = ks.createCornerPinSurface(400, 300, 20);
  calgaryScreen = createGraphics(400, 300, P3D);

  calgaryTables = new Table[5];
  for (int i = 0; i < calgaryTables.length; i++ ) {
    calgaryTables[i] = loadTable("calgary_ab/calgary_ab_" + i + ".csv");
  }
} // END OF SETUP ===================================================================================

void draw() {
  calgaryScreen.beginDraw();
  calgaryScreen.background(255);
  animateLoop(calgaryTables);
  calgaryScreen.endDraw();

  background(0);

  calgarySurface.render(calgaryScreen);
} // END OF DRAW =====================================================================================

void animateLoop(Table[] table) {
  fill(0);

  int mx = constrain(animationCounter, 0, table[tableSwitch].getRowCount());
  animationCounter++;
  theta = map(table[tableSwitch].getInt(mx, 0), 0, 500, 0, PI/2);
  println(table[tableSwitch].getInt(mx, 0));

  if (animationCounter == table[tableSwitch].getRowCount()) {
    tableSwitch++;
    animationCounter = 0;
  } else if (tableSwitch == table.length-1) {
    tableSwitch = 0;
    animationCounter = 0;
  }
  calgaryScreen.translate(calgaryScreen.width/2, calgaryScreen.height);
  calgaryScreen.stroke(0);
  branch(60);
}

void branch(float len) {

  float sw = map(len, 2, 120, 1, 10);
  calgaryScreen.strokeWeight(sw);

  calgaryScreen.line(0, 0, 0, -len);
  calgaryScreen.translate(0, -len);

  len *= 0.66;
  if (len > 2) {
    calgaryScreen.pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    calgaryScreen.rotate(theta);   // Rotate by theta
    branch(len);       // Ok, now call myself to draw two new branches!!
    calgaryScreen.popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state

    calgaryScreen.pushMatrix();
    calgaryScreen.rotate(-theta);
    branch(len);
    calgaryScreen.popMatrix();
  }
}

void keyPressed() {
  switch(key) {
  case 'c':
    // enter/leave calibration mode, where surfaces can be warped 
    // and moved
    ks.toggleCalibration();
    break;

  case 'l':
    // loads the saved layout
    ks.load();
    break;

  case 's':
    // saves the layout
    ks.save();
    break;
  }
}
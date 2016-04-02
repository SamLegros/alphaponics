// Using Keystone to create multiple windows

import deadpixel.keystone.*;

float theta;
int animationCounter;
int tableSwitch;

Keystone ks;
CornerPinSurface calgarySurface;
PGraphics calgaryScreen;

CornerPinSurface charlottetownSurface;
PGraphics charlottetownScreen;

CornerPinSurface edmontonSurface;
PGraphics edmontonScreen;

Table[] calgaryTables;
Table[] charlottetownTables;
Table[] edmontonTables;

void setup() {
  size(800, 600, P3D);
  background(255);

  ks = new Keystone(this);
  calgarySurface = ks.createCornerPinSurface(400, 300, 20);
  calgaryScreen = createGraphics(400, 300, P3D);

  charlottetownSurface = ks.createCornerPinSurface(400, 300, 20);
  charlottetownSurface.moveTo(width/2, 0);
  charlottetownScreen = createGraphics(400, 300, P3D);

  edmontonSurface = ks.createCornerPinSurface(400, 300, 20);
  edmontonSurface.moveTo(0, height/2);
  edmontonScreen = createGraphics(400, 300, P3D);

  calgaryTables = new Table[5];
  for (int i = 0; i < calgaryTables.length; i++ ) {
    calgaryTables[i] = loadTable("calgary_ab/calgary_ab_" + i + ".csv");
  }

  charlottetownTables = new Table[5];
  for (int i = 0; i < charlottetownTables.length; i++ ) {
    charlottetownTables[i] = loadTable("charlottetown_pei/charlottetown_pei_" + i + ".csv");
  }

  edmontonTables = new Table[21];
  for (int i = 0; i < edmontonTables.length; i++ ) {
    edmontonTables[i] = loadTable("edmonton_ab/edmonton_ab_" + i + ".csv");
  }
} // END OF SETUP ===================================================================================

void draw() {
  frameRate(10);
  calgaryScreen.beginDraw();
  calgaryScreen.background(255);
  animateLoop(calgaryTables, calgaryScreen);
  calgaryScreen.endDraw();

  charlottetownScreen.beginDraw();
  charlottetownScreen.background(255);
  animateLoop(charlottetownTables, charlottetownScreen);
  charlottetownScreen.endDraw();
  
  edmontonScreen.beginDraw();
  edmontonScreen.background(255);
  animateLoop(edmontonTables, edmontonScreen);
  edmontonScreen.endDraw();

  background(0);

  calgarySurface.render(calgaryScreen);
  charlottetownSurface.render(charlottetownScreen);
  edmontonSurface.render(edmontonScreen);
} // END OF DRAW =====================================================================================

void animateLoop(Table[] table, PGraphics screen) {
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
  screen.translate(screen.width/2, screen.height);
  screen.stroke(0);
  branch(60, screen);
}

void branch(float len, PGraphics screen) {

  float sw = map(len, 2, 120, 1, 10);
  screen.strokeWeight(sw);

  screen.line(0, 0, 0, -len);
  screen.translate(0, -len);

  len *= 0.66;
  if (len > 2) {
    screen.pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    screen.rotate(theta);   // Rotate by theta
    branch(len, screen);       // Ok, now call myself to draw two new branches!!
    screen.popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state

    screen.pushMatrix();
    screen.rotate(-theta);
    branch(len, screen);
    screen.popMatrix();
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
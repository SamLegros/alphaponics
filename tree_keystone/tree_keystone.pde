// Using Keystone to create multiple windows

import deadpixel.keystone.*;

float theta;
int animationCounter;
int tableSwitch;

int screenSize = 75;

Keystone ks;
CornerPinSurface calgarySurface;
PGraphics calgaryScreen;

CornerPinSurface charlottetownSurface;
PGraphics charlottetownScreen;

CornerPinSurface edmontonSurface;
PGraphics edmontonScreen;

CornerPinSurface[] surface = new CornerPinSurface[21];
PGraphics[] screen = new PGraphics[21];

PImage canada;

Table[] calgaryTables;
Table[] charlottetownTables;
Table[] edmontonTables;

void setup() {
  size(1575, 75, P3D);
  frameRate(20);
  background(255);

  ks = new Keystone(this);

  for (int i = 1; i < surface.length; i++) {
    surface[i] = ks.createCornerPinSurface(screenSize, screenSize, 20);
    surface[i].moveTo(screenSize*i, 0);
    println("surface " + i);
  }

  for (int i = 1; i < screen.length; i++) {
    screen[i] = createGraphics(screenSize, screenSize, P3D);
    println("screen " + i);
  }

  calgarySurface = ks.createCornerPinSurface(screenSize, screenSize, 20);
  calgaryScreen = createGraphics(screenSize, screenSize, P3D);

  charlottetownSurface = ks.createCornerPinSurface(screenSize, screenSize, 20);
  charlottetownSurface.moveTo(screenSize*1, 0);
  charlottetownScreen = createGraphics(screenSize, screenSize, P3D);

  edmontonSurface = ks.createCornerPinSurface(screenSize, screenSize, 20);
  edmontonSurface.moveTo(screenSize*2, 0);
  edmontonScreen = createGraphics(screenSize, screenSize, P3D);

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
  
  for (int i = 1; i < screen.length; i++) {
    screen[i].beginDraw();
    screen[i].background(random(0, 255));
    screen[i].endDraw();
  }
  
  //calgaryScreen.beginDraw();
  //calgaryScreen.background(255);
  //animateLoop(calgaryTables, calgaryScreen);
  //calgaryScreen.endDraw();

  //charlottetownScreen.beginDraw();
  //charlottetownScreen.background(255);
  //animateLoop(charlottetownTables, charlottetownScreen);
  //charlottetownScreen.endDraw();

  //edmontonScreen.beginDraw();
  //edmontonScreen.background(255);
  //animateLoop(edmontonTables, edmontonScreen);
  //edmontonScreen.endDraw();

  background(0);
  
  for (int i = 1; i < surface.length; i++) {
   surface[i].render(screen[i]);
  }

  //calgarySurface.render(calgaryScreen);
  //charlottetownSurface.render(charlottetownScreen);
  //edmontonSurface.render(edmontonScreen);
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
  branch(20, screen);
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
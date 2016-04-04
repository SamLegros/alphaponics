// Sam Legros

import deadpixel.keystone.*;    // Load Keystone library

float theta;    // Angle for producing tree branch
int animationCounter;    // Counter to parse through rows in table
int tableSwitch;    // Counter to switch table once end has been reached
int screenSize = 75;    // Size of each Keystone screen

Keystone ks; // Initialize Keystone
CornerPinSurface[] surface = new CornerPinSurface[21];    // Create array of 21 Keystone Surfaces
PGraphics[] screen = new PGraphics[21];    // Create array of 21 Keystone Screens
Table[] table = new Table[21];    // Create array of 21 Tables

//Tree[] tree;

void setup() {
  size(1500, 75, P3D);
  frameRate(20);
  background(255);

  //tree = new Tree[21];
  //for (int i = 1; i < tree.length; i++) {
  //  tree[i] = new Tree(i);
  //  tree[i].initializeScreen();
  //}

  ks = new Keystone(this);    // Load Keystone

  for (int i = 1; i < surface.length; i++) {    // Parse through amount of Surfaces in array created
    surface[i] = ks.createCornerPinSurface(screenSize, screenSize, 20);    // Create new Surface with ScreenSize size
    surface[i].moveTo(screenSize*i-screenSize, 0);    // Move Surface accordingly
    println("surface " + i);
  }

  for (int i = 1; i < screen.length; i++) {    // Parse through amount of Screens in array created
    screen[i] = createGraphics(screenSize, screenSize, P3D);    // Create new Screen with ScreenSize size
    println("screen " + i);
  }

  for (int i = 1; i < table.length; i++) {    // Parse through amount of Tables in array created
    table[i] = loadTable(i + ".csv");    // Load  Table that match with i's value
  }
} // END OF SETUP ===================================================================================

void draw() {
  for (int i = 1; i < screen.length; i++) {    // Parse through amount of Screens in array created
    screen[i].beginDraw();    // Begin Draw Screen with corresponding i value
    screen[i].background(random(0, 255));
    //animateLoop(table[i], screen[i]);
    screen[i].endDraw();    // End Draw Screen with corresponding i value
  }

  for (int i = 1; i < surface.length; i++) {    // Parse through amount of Surfaces in array created
    surface[i].render(screen[i]);    // Render Surface with corresponding i value
  }
} // END OF DRAW =====================================================================================

void animateLoop(Table[] table, PGraphics[] screen) {
  fill(0);
  int mx = constrain(animationCounter, 0, table[].getRowCount());    // Constrain mx between 0 and amount of rows in Table with corresponding i value
  animationCounter++;    // +1 to the row counter
  theta = map(table[].getInt(mx, 0), 0, 500, 0, PI/2);    // Map angle of new branch spawn to value from table
  println(table[].getInt(mx, 0));

  if (animationCounter == table[].getRowCount()) {    // If end of row is reached
    animationCounter = 0;    // Reset row count (run from beginning of table value)
  }

  screen[].translate(screen[].width/2, screen[].height);    // Translate tree to center of Keystone Screen
  screen[].stroke(0);
  branch(20, screen[]);    // Create a new branch with 60 pixel length on the corresponding Screen
}

void branch(float len, PGraphics[] screen) {

  float sw = map(len, 2, 120, 1, 10);      // Map stroke weight based on length of branch
  screen.strokeWeight(sw);

  screen.line(0, 0, 0, -len);    // Draw branch
  screen.translate(0, -len);    // Move to end of branch

  len *= 0.66;    // Multiply length of branch by amount
  if (len > 2) {    // If length of branch is less than amount
    screen.pushMatrix();    // Save the current state of transformation (Where are we now)
    screen.rotate(theta);    // Rotate by theta angle
    branch(len, screen);    // Ok, now call myself to draw two new branches!!
    screen.popMatrix();    // Whenever we get back here, we "pop" in order to restore the previous matrix state

    screen.pushMatrix();
    screen.rotate(-theta);
    branch(len, screen);
    screen.popMatrix();
  }
}

//void animateLoop(Table[] table, PGraphics screen) {
//  fill(0);

//  int mx = constrain(animationCounter, 0, table[tableSwitch].getRowCount());
//  animationCounter++;
//  theta = map(table[tableSwitch].getInt(mx, 0), 0, 500, 0, PI/2);
//  println(table[tableSwitch].getInt(mx, 0));

//  if (animationCounter == table[tableSwitch].getRowCount()) {
//    tableSwitch++;
//    animationCounter = 0;
//  } else if (tableSwitch == table.length-1) {
//    tableSwitch = 0;
//    animationCounter = 0;
//  }
//  screen.translate(screen.width/2, screen.height);
//  screen.stroke(0);
//  branch(20, screen);
//}

//void branch(float len, PGraphics screen) {

//  float sw = map(len, 2, 120, 1, 10);
//  screen.strokeWeight(sw);

//  screen.line(0, 0, 0, -len);
//  screen.translate(0, -len);

//  len *= 0.66;
//  if (len > 2) {
//    screen.pushMatrix();    // Save the current state of transformation (i.e. where are we now)
//    screen.rotate(theta);   // Rotate by theta
//    branch(len, screen);       // Ok, now call myself to draw two new branches!!
//    screen.popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state

//    screen.pushMatrix();
//    screen.rotate(-theta);
//    branch(len, screen);
//    screen.popMatrix();
//  }
//}

void keyPressed() {
  switch(key) {
  case 'c':
    ks.toggleCalibration();    // Enter/Exit the calibration mode, where surfaces can be warped and moved
    break;

  case 'l':
    ks.load();    // Loads the saved layout  
    break;

  case 's':
    ks.save();    // Saves the layout
    break;
  }
}
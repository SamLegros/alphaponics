// Sam Legros

import deadpixel.keystone.*;    // Load Keystone library

float theta;    // Angle for producing tree branch
int animationCounter;    // Counter to parse through rows in table
int tableSwitch;    // Counter to switch table once end has been reached
int screenSize = 75;    // Size [amount] of each Keystone screen

Keystone ks; // Initialize Keystone
CornerPinSurface surface;    // Create array of [amount] Keystone Surfaces
PGraphics screen;    // Create array of [amount] Keystone Screens
Table table;    // Create array of [amount] Tables

Tree[] tree;





void setup() {
  size(1500, 75, P3D);
  frameRate(20);
  background(255);

  ks = new Keystone(this);    // Load Keystone

  tree = new Tree[21];
  for (int i = 1; i < tree.length; i++) {
    surface = ks.createCornerPinSurface(screenSize, screenSize, 20);    // Create new Surface with ScreenSize size
    surface.moveTo(screenSize*i-screenSize, 0);    // Move Surface accordingly
    screen = createGraphics(screenSize, screenSize, P3D);    // Create new Screen with ScreenSize size
    tree[i] = new Tree(i, surface, screen);
  }
} // END OF SETUP ===================================================================================





void draw() {
  for (int i = 1; i < tree.length; i++) {    // Parse through amount of Screens in array created
    tree[i].screenTree();
  }

  for (int i = 1; i < tree.length; i++) {    // Parse through amount of Surfaces in array created
    //surface[i].render(screen[i]);    // Render Surface with corresponding i value
    tree[i].surfaceTree();
  }
} // END OF DRAW =====================================================================================





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
}// END OF KEYPRESSED =====================================================================================
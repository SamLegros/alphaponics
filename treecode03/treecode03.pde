float theta;

Table[] calgaryTables;
IntList calgaryValues;
int calgaryRowValue;

int animationCounter;
int tableSwitch;

void setup() {
  size(640, 360);

  //calgaryValues = new IntList();
  calgaryTables = new Table[5];
  for (int i = 0; i < calgaryTables.length; i++ ) {
    calgaryTables[i] = loadTable("calgary_ab/calgary_ab_" + i + ".csv");
  }
} // End of setup()

void draw() {
  background(255);
  animateLoop(calgaryTables);
} // End of draw()

void animateLoop(Table[] table) {
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
  translate(width/2, height);
  stroke(0);
  branch(100);
}

void branch(float len) {
  // Each branch will be 2/3rds the size of the previous one
  float sw = map(len, 2, 120, 1, 10);
  strokeWeight(sw);

  line(0, 0, 0, -len);
  // Move to the end of that line
  translate(0, -len);

  len *= 0.66;
  // All recursive functions must have an exit condition!!!!
  // Here, ours is when the length of the branch is 2 pixels or less
  //hack point
  if (len > 2) {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(theta);   // Rotate by theta
    branch(len);       // Ok, now call myself to draw two new branches!!
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state

    // Repeat the same thing, only branch off to the "left" this time!
    pushMatrix();
    rotate(-theta);
    branch(len);
    popMatrix();
  }
}
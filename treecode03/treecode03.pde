float theta;

Table calgaryTable;
int calgaryTableRowCount;
IntList calgaryValues;
int calgaryRowValue;

int animationCounter;

void setup() {
  size(640, 360);

  calgaryTable = loadTable("homemade/2012_calgary.csv");
  calgaryTableRowCount = calgaryTable.getRowCount();

  calgaryValues = new IntList();

  for (int i = 0; i < calgaryTableRowCount; i++) {
    calgaryRowValue = calgaryTable.getInt(i, 0); // Get values from table
    //println(rowValue);
    calgaryValues.set(i, calgaryRowValue); // Set values from table into index
    //println(calgaryValues.get(i));
  }
} // End of setup()

void draw() {
  background(255);
  int mx = constrain(animationCounter, 0, calgaryTable.getRowCount()-1);

  animationCounter++;

  theta = map(calgaryValues.get(mx), 0, width, 0, PI/2);

  //theta = map(mouseX,0,width,0,PI/2); // Maps theta between 0 degrees and 90 degrees

  // Start the tree from the bottom of the screen
  translate(width/2, height);
  stroke(0);
  //hack point
  branch(100);
} // End of draw()

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
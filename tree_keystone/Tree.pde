class Tree {

  int id;

  CornerPinSurface surface;    // Create array of [amount] Keystone Surfaces
  PGraphics screen;    // Create array of [amount] Keystone Screens
  Table table;    // Create array of [amount] Tables

  Tree(int _i, CornerPinSurface _surface, PGraphics _screen) {
    id = _i;
    surface = _surface;
    screen = _screen;
    table = loadTable(_i + ".csv");    // Load  Table that match with i's value
  }

  void screenTree() {
    screen.beginDraw();    // Begin Draw Screen with corresponding i value
    screen.background(255);
    animateLoop(table, screen);
    screen.endDraw();    // End Draw Screen with corresponding i value
  }

  void surfaceTree() {

    surface.render(screen);    // Render Surface with corresponding i value
  }

  void animateLoop(Table table, PGraphics screen) {
    fill(0);
    int mx = constrain(animationCounter, 0, table.getRowCount());    // Constrain mx between 0 and amount of rows in Table with corresponding i value
    animationCounter++;    // +1 to the row counter
    if (animationCounter == table.getRowCount()) {    // If end of row is reached
      animationCounter = 0;    // Reset row count (run from beginning of table value)
    }
    theta = map(table.getInt(mx, 0), 0, 500, 0, PI/2);    // Map angle of new branch spawn to value from table
    println(table.getInt(mx, 0));

    screen.translate(screen.width/2, screen.height);    // Translate tree to center of Keystone Screen
    screen.stroke(0);
    branch(20, screen);    // Create a new branch with [amount] pixel length on the corresponding Screen
  }

  void branch(float len, PGraphics screen) {

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

      // Same as above, but opposite side (left side)
      screen.pushMatrix();
      screen.rotate(-theta);
      branch(len, screen);
      screen.popMatrix();
    }
  }
}
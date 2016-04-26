float theta;
int frameCounter;

void setup() {
  size(700, 600);
  smooth();
  frameRate(30);
}

void draw() {
  background(255);
  frameCounter += 1;
  theta = map(frameCounter, 0, width, 0, PI/2);

  translate(width/2, height);
  stroke(0);
  branch(200, int(random(0, 256)));
}

void branch(float len, int c) {
  float sw = map(len, 2, 120, 1, 10);
  strokeWeight(sw);
  stroke(c);
  line(0, 0, 0, -len);
  // Move to the end of that line
  translate(0, -len);

  len *= 0.66;
  if (len > 2) {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(theta);   // Rotate by theta
    branch(len, c);       // Ok, now call myself to draw two new branches!!
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state

    pushMatrix();
    rotate(-theta);
    branch(len, c);
    popMatrix();
  }
}
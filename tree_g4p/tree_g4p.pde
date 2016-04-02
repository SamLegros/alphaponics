import g4p_controls.*;
GWindow window;

void setup() {
  size(500, 500);

  window =  GWindow.getWindow(this, "tree1", 100, 50, 480, 320, JAVA2D);
  window.addDrawHandler(this, "windowDraw");
}

void draw() {
}

void windowDraw(PApplet app, GWinData data) {
  app.background(255);
  
}






// FROM ORIGINAL windowDraw function
  //app.strokeWeight(2);
  //// draw black line to current mouse position
  //app.stroke(0);
  //app.line(app.width / 2, app.height/2, app.mouseX, app.mouseY);
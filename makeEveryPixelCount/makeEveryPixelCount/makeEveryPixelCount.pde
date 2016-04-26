// x1 (370, 115)
// x2 (740, 230)
// x3 (1110, 345)

PImage img1;
PImage img2;
PImage img3;
PImage img4;
PImage img5;

void setup() {
  //size(370, 115);
  //img1 = loadImage("makeEveryPixelCountx1.png");

  //size(740, 230);
  //img2 = loadImage("makeEveryPixelCountx2.png");

  //size(1110, 345);
  //img3 = loadImage("makeEveryPixelCountx3.png");

  //size(345, 1110);
  //img4 = loadImage("makeEveryPixelCountx3R.png");

  size(230, 740);
  img5 = loadImage("makeEveryPixelCountx2R.png");
}

void draw() {
  image(img5, 0, 0);
  println(mouseX, mouseY);

  if (mouseY == 1|| mouseX == 2) {
    if (mouseX < width/2) {
      println("ONE");
      fill(255);
      rect(mouseX, mouseY, 100, 50);
      fill(0);
      text("Producer deliveries of major grains, Canada and selected", mouseX, 10);
    } else if (mouseX > width/2) {
      println("ONE");
      fill(255);
      rect(mouseX-100, mouseY, 100, 50);
    }
  }
}
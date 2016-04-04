class Tree {

 int id;

 Tree(int _i) {
   id = _i;
 }

 void initializeScreen() {
   for (int i = 1; i < screen.length; i++) {
     screen[i] = createGraphics(screenSize, screenSize, P3D);
     println("screen " + i);
   }
 }
}
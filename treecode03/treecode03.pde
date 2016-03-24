float theta;

Table[] calgaryTables;
Table[] charlottetownTables;
Table[] edmontonTables;
Table[] frederictonTables;
Table[] halifaxTables;
Table[] iqaluitTables;
Table[] montrealTables;
Table[] ottawaTables;
Table[] princeGeorgeTables;
Table[] quebecTables;
Table[] reginaTables;
Table[] saskatoonTables;
Table[] stJohnsTables;
Table[] thunderBayTables;
Table[] torontoTables;
Table[] vancouverTables;
Table[] victoriaTables;
Table[] whitehorseTables;
Table[] winnipegTables;
Table[] yellowknifeTables;

int animationCounter;
int tableSwitch;

void setup() {
  //size(640, 360); // Original sizing
  size(360, 360);

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

  frederictonTables = new Table[7];
  for (int i = 0; i < frederictonTables.length; i++ ) {
    frederictonTables[i] = loadTable("fredericton_nb/fredericton_nb_" + i + ".csv");
  }

  halifaxTables = new Table[5];
  for (int i = 0; i < halifaxTables.length; i++ ) {
    halifaxTables[i] = loadTable("halifax_ns/halifax_ns_" + i + ".csv");
  }

  iqaluitTables = new Table[13];
  for (int i = 0; i < iqaluitTables.length; i++ ) {
    iqaluitTables[i] = loadTable("iqaluit_nu/iqaluit_nu_" + i + ".csv");
  }

  montrealTables = new Table[4];
  for (int i = 0; i < montrealTables.length; i++ ) {
    montrealTables[i] = loadTable("montreal_qc/montreal_qc_" + i + ".csv");
  }

  ottawaTables = new Table[6];
  for (int i = 0; i < ottawaTables.length; i++ ) {
    ottawaTables[i] = loadTable("ottawa_on/ottawa_on_" + i + ".csv");
  }

  princeGeorgeTables = new Table[8];
  for (int i = 0; i < princeGeorgeTables.length; i++ ) {
    princeGeorgeTables[i] = loadTable("prince_george_bc/prince_george_bc_" + i + ".csv");
  }

  quebecTables = new Table[25];
  for (int i = 0; i < quebecTables.length; i++ ) {
    quebecTables[i] = loadTable("quebec_qc/quebec_qc_" + i + ".csv");
  }

  reginaTables = new Table[18];
  for (int i = 0; i < reginaTables.length; i++ ) {
    reginaTables[i] = loadTable("regina_sk/regina_sk_" + i + ".csv");
  }

  saskatoonTables = new Table[9];
  for (int i = 0; i < saskatoonTables.length; i++ ) {
    saskatoonTables[i] = loadTable("saskatoon_sk/saskatoon_sk_" + i + ".csv");
  }

  stJohnsTables = new Table[5];
  for (int i = 0; i < stJohnsTables.length; i++ ) {
    stJohnsTables[i] = loadTable("st_johns_nl/st_johns_nl_" + i + ".csv");
  }

  thunderBayTables = new Table[14];
  for (int i = 0; i < thunderBayTables.length; i++ ) {
    thunderBayTables[i] = loadTable("thunder_bay_on/thunder_bay_on_" + i + ".csv");
  }

  torontoTables = new Table[4];
  for (int i = 0; i < torontoTables.length; i++ ) {
    torontoTables[i] = loadTable("toronto_on/toronto_on_" + i + ".csv");
  }

  vancouverTables = new Table[4];
  for (int i = 0; i < vancouverTables.length; i++ ) {
    vancouverTables[i] = loadTable("vancouver_bc/vancouver_bc_" + i + ".csv");
  }

  victoriaTables = new Table[4];
  for (int i = 0; i < victoriaTables.length; i++ ) {
    victoriaTables[i] = loadTable("victoria_bc/victoria_bc_" + i + ".csv");
  }

  whitehorseTables = new Table[8];
  for (int i = 0; i < whitehorseTables.length; i++ ) {
    whitehorseTables[i] = loadTable("whitehorse_yt/whitehorse_yt_" + i + ".csv");
  }

  winnipegTables = new Table[21];
  for (int i = 0; i < winnipegTables.length; i++ ) {
    winnipegTables[i] = loadTable("winnipeg_mb/winnipeg_mb_" + i + ".csv");
  }
  yellowknifeTables = new Table[4];
  for (int i = 0; i < yellowknifeTables.length; i++ ) {
    yellowknifeTables[i] = loadTable("yellowknife_nt/yellowknife_nt_" + i + ".csv");
  }
} // End of setup()

void draw() {
  background(255);
  //animateLoop(calgaryTables);
  //animateLoop(charlottetownTables);
  //animateLoop(edmontonTables);
  //animateLoop(frederictonTables);
  //animateLoop(halifaxTables);
  //animateLoop(iqaluitTables);
  //animateLoop(montrealTables);
  //animateLoop(ottawaTables);
  //animateLoop(princeGeorgeTables);
  //animateLoop(quebecTables);
  //animateLoop(reginaTables);
  //animateLoop(saskatoonTables);
  //animateLoop(stJohnsTables);
  //animateLoop(thunderBayTables);
  //animateLoop(torontoTables);
  //animateLoop(vancouverTables);
  //animateLoop(victoriaTables);
  //animateLoop(whitehorseTables);
  //animateLoop(winnipegTables);
  animateLoop(yellowknifeTables);
} // End of draw()

void animateLoop(Table[] table) {
  fill(0);
  //text("charlottetown", 10, height-15);

  int mx = constrain(animationCounter, 0, table[tableSwitch].getRowCount());
  animationCounter++;
  theta = map(table[tableSwitch].getInt(mx, 0), 0, 500, 0, PI/2);
  println(table[tableSwitch].getInt(mx, 0));

  if (animationCounter == table[tableSwitch].getRowCount()) {
    tableSwitch++;
    animationCounter = 0;
  }
  //else if (tableSwitch == table.length-1) {
  //  tableSwitch = 0;
  //  animationCounter = 0;
  //}
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
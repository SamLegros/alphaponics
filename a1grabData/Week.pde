class Week {

  int id;
  int prog;
  int retro;
  int growStatus;

  float minTempMin;
  float minTempMax;
  float minTempRange;

  float maxTempMin;
  float maxTempMax;
  float maxTempRange;

  float meanTempMin;
  float meanTempMax;
  float meanTempRange;

  float rainMin;
  float rainMax;
  float rainRange;

  float snowMin;
  float snowMax;
  float snowRange;

  float speedMaxGustMin;
  float speedMaxGustMax;
  float speedMaxGustRange;

  // classes for all weather data
  Week(int _i) {
    id = _i;
  }

  void saveMinTempValues(float _minTempMin, float _minTempMax, float _minTempRange) {
    println(id);
    minTempMin = _minTempMin;
    minTempMax = _minTempMax;
    minTempRange = _minTempRange;
    println("MinTempMin: " + minTempMin);
    println("MinTempMax: " + minTempMax);
    println("MinTempRange: " + minTempRange);

    // +1 to either PROG or RETRO depending on minimum minimum temperature
    if (minTempMin < 0.0 || minTempMin > 40.0) {
      retro++;
      //println("RETRO: minTempMin");
    } else if ((minTempMin > 0.0 && minTempMin < 10.0) || (minTempMin > 30.0 && minTempMin < 40.0)) {
      //println("STAG: minTempMin");
    } else if (minTempMin > 10.0 && minTempMin < 30.0) {
      prog++;
      //println("PROG: minTempMin");
    } else {
      //println("NAN: minTempMin");
    }

    // +1 to either PROG or RETRO depending on maximum minimum temperature
    if (minTempMax < 0.0 || minTempMax > 40.0) {
      retro++;
      //println("RETRO: minTempMax");
    } else if ((minTempMax > 0.0 && minTempMax < 10.0) || (minTempMax > 30.0 && minTempMax < 40.0)) {
      //println("STAG: minTempMax");
    } else if (minTempMax > 10.0 && minTempMax < 30.0) {
      prog++;
      //println("PROG: minTempMax");
    } else {
      //println("NAN: minTempMax");
    }

    // +1 to either PROG or RETRO depending on the range of minimum temperature
    if (minTempRange > 14.0) {
      retro++;
      //println("RETRO: minTempRange");
    } else if (minTempRange < 7.0) {
      //println("STAG: minTempRange");
    } else if (minTempRange > 7.0 && minTempRange < 14.0) {
      prog++;
      //println("PROG: minTempRange");
    } else {
      //println("NAN: minTempRange");
    }

    growStatus = prog-retro;
    println(xCoordinateCounter);
    println(growStatus);
    screenDraw(screenNum);
  } // End of saveMinTempValues()

  void xCoordinateCounter() {
    xCoordinateCounter = xCoordinateCounter+10;
    growStatus = prog-retro;
  } // End of xCoordinateCounter()

  void display() {
    fill(0);
    ellipse(xCoordinateCounter, growStatus+height/2, 1, 1);
  } // End of display()
} // End of Week class
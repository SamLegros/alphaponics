// Alphaponics by Sam Legros

int weekCounter;
int prog;
int retro;
int xCoordinateCounter;
int growStatus;

int screenNum;

int[] savedX;
int[] savedValues;
int switchCounter;
int switchCounterConstrain = constrain(switchCounter, 0, 52);
int delay = 100;

Table[] calgaryTables;

void setup() {
  size(600, 600);
  background(255);
  fill(0);
  line(0, height/2, width, height/2);

  calgaryTables = new Table[5];
  for (int i = 0; i < calgaryTables.length; i++) {
    calgaryTables[i] = loadTable("calgary_ab/daily_calgary_ab_" + i + ".csv");
  }

  savedX = new int[53];
  savedValues = new int[53];

  getValues(calgaryTables[0]);
} // End of setup()

void draw() {
  screenDraw(screenNum);
}

void getValues(Table table) {
  // Scan through all of the rows in the table
  for (int i = 1; i < table.getRowCount(); i++) { // Go through all rows
    weekCounter++;
    if (weekCounter % 7 == 0) {
      println("week: " + weekCounter/7);

      // Initialize local variables
      int currentWeek = i/7;
      int day1 = i-6;
      int day2 = i-5;
      int day3 = i-4;
      int day4 = i-3;
      int day5 = i-2;
      int day6 = i-1;
      int day7 = i;

      // MINIMUM TEMPERATURE ==================================================================================================================================================================================================================================================================

      // Save the minimum temperatures of the previous days in the past week
      if (table.getString(day1, 5) != "NaN") {
        float[] minTempValues = { table.getFloat(day1, 5), table.getFloat(day2, 5), table.getFloat(day3, 5), table.getFloat(day4, 5), table.getFloat(day5, 5), table.getFloat(day6, 5), table.getFloat(day7, 5)};
        //println(minTempValues);

        // Minimum minimum temperature for the week
        float minTempMin = min(minTempValues);
        //println("Week " + currentWeek + " Min Min Temp: " + minTempMin);

        // Maximum minimum temperature for the week
        float minTempMax = max(minTempValues);
        //println("Week " + currentWeek + " Max Min Temp: " + minTempMax);

        // Minimum temperature range for the week
        float minTempRange = minTempMax-minTempMin;
        //println("Week " + currentWeek + " Min Temp Range: " + minTempRange);

        // Average minimum temperature for the week (NOT WORKING BECAUSE OF NAN VALUE FOR MISSING NUMBERS)
        //float minTempAverage = table.getFloat(day1, 5) + table.getFloat(day2, 5) + table.getFloat(day3, 5) + table.getFloat(day4, 5) + table.getFloat(day5, 5) + table.getFloat(day6, 5) + table.getFloat(day7, 5);
        //println("Week " + currentWeek + " Average Temp: " + minTempAverage);

        // +1 to either PROG or RETRO depending on minimum minimum temperature
        if (minTempMin < 0.0 || minTempMin > 40.0) {
          retro++;
          println("RETRO: minTempMin");
        } else if ((minTempMin > 0.0 && minTempMin < 10.0) || (minTempMin > 30.0 && minTempMin < 40.0)) {
          println("STAG: minTempMin");
        } else if (minTempMin > 10.0 && minTempMin < 30.0) {
          prog++;
          println("PROG: minTempMin");
        } else {
          println("NAN: minTempMin");
        }

        // +1 to either PROG or RETRO depending on maximum minimum temperature
        if (minTempMax < 0.0 || minTempMax > 40.0) {
          retro++;
          println("RETRO: minTempMax");
        } else if ((minTempMax > 0.0 && minTempMax < 10.0) || (minTempMax > 30.0 && minTempMax < 40.0)) {
          println("STAG: minTempMax");
        } else if (minTempMax > 10.0 && minTempMax < 30.0) {
          prog++;
          println("PROG: minTempMax");
        } else {
          println("NAN: minTempMax");
        }

        // +1 to either PROG or RETRO depending on the range of minimum temperature
        if (minTempRange > 14.0) {
          retro++;
          println("RETRO: minTempRange");
        } else if (minTempRange < 7.0) {
          println("STAG: minTempRange");
        } else if (minTempRange > 7.0 && minTempRange < 14.0) {
          prog++;
          println("PROG: minTempRange");
        } else {
          println("NAN: minTempRange");
        }
      }

      // MAXIMUM TEMPERATURE ==================================================================================================================================================================================================================================================================

      // Save the maximum temperatures of the previous days in the past week
      float[] maxTempValues = { table.getFloat(day1, 7), table.getFloat(day2, 7), table.getFloat(day3, 7), table.getFloat(day4, 7), table.getFloat(day5, 7), table.getFloat(day6, 7), table.getFloat(day7, 7)};
      //println(maxTempValues);

      // Minimum maximum temperature for the week
      float maxTempMin = min(maxTempValues);
      //println("Week " + currentWeek + " Min Max Temp: " + maxTempMin);

      // Maximum maximum temperature for the week
      float maxTempMax = max(maxTempValues);
      //println("Week " + currentWeek + " Max Max Temp: " + maxTempMax);

      // Maximum temperature range for the week
      float maxTempRange = maxTempMax-maxTempMin;
      //println("Week " + currentWeek + " Max Temp Range: " + maxTempRange);

      // +1 to either PROG or RETRO depending on minimum maximum temperature
      if (maxTempMin < 0.0 || maxTempMin > 40.0) {
        retro++;
        println("RETRO: maxTempMin");
      } else if ((maxTempMin > 0.0 && maxTempMin < 10.0) || (maxTempMin > 30.0 && maxTempMin < 40.0)) {
        println("STAG: maxTempMin");
      } else if (maxTempMin > 10.0 && maxTempMin < 30.0) {
        prog++;
        println("PROG: maxTempMin");
      } else {
        println("NAN: maxTempMin");
      }

      // +1 to either PROG or RETRO depending on maximum maximum temperature
      if (maxTempMax < 0.0 || maxTempMax > 40.0) {
        retro++;
        println("RETRO: maxTempMax");
      } else if ((maxTempMax > 0.0 && maxTempMax < 10.0) || (maxTempMax > 30.0 && maxTempMax < 40.0)) {
        println("STAG: maxTempMax");
      } else if (maxTempMax > 10.0 && maxTempMax < 30.0) {
        prog++;
        println("PROG: maxTempMax");
      } else {
        println("NAN: maxTempMax");
      }

      // +1 to either PROG or RETRO depending on the range of maximum temperature
      if (maxTempRange > 14.0) {
        retro++;
        println("RETRO: maxTempRange");
      } else if (maxTempRange < 7.0) {
        println("STAG: maxTempRange");
      } else if (maxTempRange > 7.0 && maxTempRange < 14.0) {
        prog++;
        println("PROG: maxTempRange");
      } else {
        println("NAN: maxTempRange");
      }

      // MEAN (AVERAGE) TEMPERATURE ==================================================================================================================================================================================================================================================================

      // Save the mean temperatures of the previous days in the past week
      float[] meanTempValues = { table.getFloat(day1, 9), table.getFloat(day2, 9), table.getFloat(day3, 9), table.getFloat(day4, 9), table.getFloat(day5, 9), table.getFloat(day6, 9), table.getFloat(day7, 9)};
      //println(meanTempValues);

      // Minimum mean temperature for the week
      float meanTempMin = min(meanTempValues);
      //println("Week " + currentWeek + " Min Mean Temp: " + meanTempMin);

      // Maximum mean temperature for the week
      float meanTempMax = max(meanTempValues);
      //println("Week " + currentWeek + " Max Mean Temp: " + meanTempMax);

      // Mean temperature range for the week
      float meanTempRange = meanTempMax-meanTempMin;
      //println("Week " + currentWeek + " Mean Temp Range: " + meanTempRange);

      // +1 to either PROG or RETRO depending on minimum mean temperature
      if (meanTempMin < 0.0 || meanTempMin > 40.0) {
        retro++;
        println("RETRO: meanTempMin");
      } else if ((meanTempMin > 0.0 && meanTempMin < 10.0) || (meanTempMin > 30.0 && meanTempMin < 40.0)) {
        println("STAG: meanTempMin");
      } else if (maxTempMin > 10.0 && maxTempMin < 30.0) {
        prog++;
        println("PROG: meanTempMin");
      } else {
        println("NAN: meanTempMin");
      }

      // +1 to either PROG or RETRO depending on maximum mean temperature
      if (meanTempMax < 0.0 || meanTempMax > 40.0) {
        retro++;
        println("RETRO: meanTempMax");
      } else if ((meanTempMax > 0.0 && meanTempMax < 10.0) || (meanTempMax > 30.0 && meanTempMax < 40.0)) {
        println("STAG: meanTempMax");
      } else if (meanTempMax > 10.0 && meanTempMax < 30.0) {
        prog++;
        println("PROG: meanTempMax");
      } else {
        println("NAN: meanTempMax");
      }

      // +1 to either PROG or RETRO depending on the range of mean temperature
      if (meanTempRange > 14.0) {
        retro++;
        println("RETRO: meanTempRange");
      } else if (meanTempRange < 7.0) {
        println("STAG: meanTempRange");
      } else if (meanTempRange > 7.0 && meanTempRange < 14.0) {
        prog++;
        println("PROG: meanTempRange");
      } else {
        println("NAN: meanTempRange");
      }

      // TOTAL RAIN ==================================================================================================================================================================================================================================================================

      // Save the rain total of the previous days in the past week
      float[] rainValues = { table.getFloat(day1, 15), table.getFloat(day2, 15), table.getFloat(day3, 15), table.getFloat(day4, 15), table.getFloat(day5, 15), table.getFloat(day6, 15), table.getFloat(day7, 15)};
      //println(rainValues);

      // Minimum rain total temperature for the week
      float rainMin = min(rainValues);
      //println("Week " + currentWeek + " Min Rain: " + rainMin);

      // Maximum rain total temperature for the week
      float rainMax = max(rainValues);
      //println("Week " + currentWeek + " Max Rain: " + meanTempMax);

      // Rain total range for the week
      float rainRange = rainMax-rainMin;
      //println("Week " + currentWeek + " Rain Range: " + rainRange);

      // +1 to either PROG or RETRO depending on minimum rain amount
      if (rainMin == 0.0 || rainMin > 30.0) {
        retro++;
        println("RETRO: rainMin");
      } else if (rainMin > 0.0 && rainMin < 30.0) {
        prog++;
        println("PROG: rainMin");
      } else {
        println("NAN: rainMin");
      }

      // +1 to either PROG or RETRO depending on maximum rain amount
      if (rainMax == 0.0 || rainMax > 30.0) {
        retro++;
        println("RETRO: rainMax");
      } else if (rainMax > 0.0 && rainMax < 30.0) {
        prog++;
        println("PROG: rainMax");
      } else {
        println("NAN: rainMax");
      }

      // +1 to either PROG or RETRO depending on the range of rain amount
      if (rainRange == 0.0 || rainRange > 30.0) {
        retro++;
        println("RETRO: rainRange");
      } else if (rainRange > 0.0 && rainRange < 30.0) {
        prog++;
        println("PROG: rainRange");
      } else {
        println("NAN: rainRange");
      }

      // TOTAL SNOW ==================================================================================================================================================================================================================================================================

      // Save the snow total of the previous days in the past week
      float[] snowValues = { table.getFloat(day1, 17), table.getFloat(day2, 17), table.getFloat(day3, 17), table.getFloat(day4, 17), table.getFloat(day5, 17), table.getFloat(day6, 17), table.getFloat(day7, 17)};
      //println(snowValues);

      // Minimum snow total for the week
      float snowMin = min(snowValues);
      //println("Week " + currentWeek + " Min Snow: " + snowMin);

      // Maximum snow total for the week
      float snowMax = max(snowValues);
      //println("Week " + currentWeek + " Max Snow: " + snowMax);

      // Snow total range for the week
      float snowRange = snowMax-snowMin;
      //println("Week " + currentWeek + " Snow Range: " + snowRange);

      // +1 to either PROG or RETRO depending on minimum snow amount
      if (snowMin > 5.0) {
        retro++;
        println("RETRO: snowMin");
      } else if (snowMin > 0.0 && snowMin < 5.0) {
        println("STAG: snowMin");
      } else if (snowMin == 0.0) {
        prog++;
        println("PROG: snowMin");
      } else {
        println("NAN: snowMin");
      }

      // +1 to either PROG or RETRO depending on maximum snow amount
      if (snowMax > 5.0) {
        retro++;
        println("RETRO: snowMax");
      } else if (snowMax > 0.0 && snowMax < 5.0) {
        println("STAG: snowMax");
      } else if (snowMax == 0.0) {
        prog++;
        println("PROG: snowMax");
      } else {
        println("NAN: snowMax");
      }

      // +1 to either PROG or RETRO depending on the range of snow amount
      if (snowRange > 5.0) {
        retro++;
        println("RETRO: snowRange");
      } else if (snowRange > 0.0 && snowRange < 5.0) {
        println("STAG: snowRange");
      } else if (snowRange == 0.0) {
        prog++;
        println("PROG: snowRange");
      } else {
        println("NAN: snowRange");
      }

      // SPEED OF MAX GUST ==================================================================================================================================================================================================================================================================

      // Save the speed of max gust of the previous days in the past week
      float[] speedMaxGustValues = { table.getFloat(day1, 25), table.getFloat(day2, 25), table.getFloat(day3, 25), table.getFloat(day4, 25), table.getFloat(day5, 25), table.getFloat(day6, 25), table.getFloat(day7, 25)};
      //println(speedMaxGustValues);

      // Minimum speed of max gust for the week
      float speedMaxGustMin = min(speedMaxGustValues);
      //println("Week " + currentWeek + " Min Speed of Max Gust: " + speedMaxGustMin);

      // Maximum speed of max gust for the week
      float speedMaxGustMax = max(speedMaxGustValues);
      //println("Week " + currentWeek + " Max Speed of Max Gust: " + speedMaxGustMax);

      // Speed of max gust range for the week
      float speedMaxGustRange = speedMaxGustMax-speedMaxGustMin;
      //println("Week " + currentWeek + " Speed of Max Gust Range: " + speedMaxGustRange);

      // +1 to either PROG or RETRO depending on minimum speed of max gust
      if (speedMaxGustMin > 35.0) {
        retro++;
        println("RETRO: speedMaxGustMin");
      } else if (speedMaxGustMin == 0.0 || speedMaxGustMin < 35.0) {
        prog++;
        println("PROG: speedMaxGustMin");
      } else {
        println("NAN: speedMaxGustMin");
      }

      // +1 to either PROG or RETRO depending on maximum speed of max gust
      if (speedMaxGustMax > 35.0) {
        retro++;
        println("RETRO: speedMaxGustMax");
      } else if (speedMaxGustMax == 0.0 || speedMaxGustMax < 35.0) {
        prog++;
        println("PROG: speedMaxGustMax");
      } else {
        println("NAN: speedMaxGustMax");
      }

      // +1 to either PROG or RETRO depending on the range of speed of max gust
      if (speedMaxGustRange > 35.0) {
        retro++;
        println("RETRO: speedMaxGustRange");
      } else if (speedMaxGustRange == 0.0 || speedMaxGustRange < 35.0) {
        prog++;
        println("PROG: speedMaxGustRange");
      } else {
        println("NAN: speedMaxGustRange");
      }

      growStatus = prog-retro;
      xCoordinateCounter = xCoordinateCounter+10;

      savedX[currentWeek] = xCoordinateCounter;
      savedValues[currentWeek] = growStatus;
      println(savedValues[0]);
      fill(0);
      //ellipse(xCoordinateCounter, growStatus+height/2, 1, 1);
      println(growStatus);
      println(xCoordinateCounter);

      if (currentWeek == 52) {
        screenDraw(screenNum);
      } // of if(currentWeek == 52)
    } // End of weekly counter
  } // End of searching through all rows in table
} // End of getValues()

void screenDraw(int pointer) {
  switch(pointer) {
  case 0:
    // switchCounterConstrain will always equal one more than the case number
    background(255);
    switchCounterConstrain = 1;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 1:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 2:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 3:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 4:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 5:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 6:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 7:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 8:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 9:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 10:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 11:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 12:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 13:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 14:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 15:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 16:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 17:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 18:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 19:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 20:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 21:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 22:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 23:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 24:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 25:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 26:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 27:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 28:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 29:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 30:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 31:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 32:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 33:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 34:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 35:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 36:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 37:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 38:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 39:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 40:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 41:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 42:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 43:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 44:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 45:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 46:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 47:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 48:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    break;
  case 49:
    switchCounterConstrain++;
    delay(delay);
    ellipse(savedX[switchCounterConstrain], savedValues[switchCounterConstrain]+height/2, 1, 1);
    screenNum = switchCounterConstrain;
    println(switchCounterConstrain);
    screenNum = 0;
    break;
  } // End of switch()
} // End of screenDraw()
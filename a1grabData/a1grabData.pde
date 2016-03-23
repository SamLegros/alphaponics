// Alphaponics by Sam Legros

Table daily_calgary_ab_2012;
Table daily_calgary_ab_2013;
Table daily_calgary_ab_2014;
Table daily_calgary_ab_2015;
Table daily_calgary_ab_2016;

int weekCounter;
int prog;
int retro;
int xCoordinateCounter;
int growStatus;

int screenNum;

Week[] weeks;

void setup() {
  weeks = new Week[53];
  for (int i = 0; i < weeks.length; i++) {
    weeks[i] = new Week(i);
  }
  size(600, 600);
  background(255);
  line(0, height/2, width, height/2);
  daily_calgary_ab_2012 = loadTable("calgary_ab/daily_calgary_ab_2012.csv");
  daily_calgary_ab_2013 = loadTable("calgary_ab/daily_calgary_ab_2013.csv");

  for (int i = 1; i < daily_calgary_ab_2012.getRowCount(); i++) { // Go through all rows
    weekCounter++;
    if (weekCounter % 7 == 0) {
      println("week: " + weekCounter/7);

      int currentWeek = i/7;
      int day1 = i-6;
      int day2 = i-5;
      int day3 = i-4;
      int day4 = i-3;
      int day5 = i-2;
      int day6 = i-1;
      int day7 = i;

      // MINIMUM TEMPERATURE ==================================================================================================================================================================================================================================================================

      if (daily_calgary_ab_2013.getString(day1, 5) != "NaN") {
        float[] minTempValues = { daily_calgary_ab_2013.getFloat(day1, 5), daily_calgary_ab_2013.getFloat(day2, 5), daily_calgary_ab_2013.getFloat(day3, 5), daily_calgary_ab_2013.getFloat(day4, 5), daily_calgary_ab_2013.getFloat(day5, 5), daily_calgary_ab_2013.getFloat(day6, 5), daily_calgary_ab_2013.getFloat(day7, 5)};

        float minTempMin = min(minTempValues);
        float minTempMax = max(minTempValues);
        float minTempRange = minTempMax-minTempMin;

        weeks[currentWeek].saveMinTempValues(minTempMin, minTempMax, minTempRange);
        xCoordinateCounter+=10;
      }

      //growStatus = prog-retro;
      //xCoordinateCounter = xCoordinateCounter+10;
      //fill(0);
      //ellipse(xCoordinateCounter, growStatus+height/2, 1, 1);
      //println(growStatus);
      //println(xCoordinateCounter);
    } // End of weekly counter
  } // End of searching through all rows in table
} // End of setup()

void draw() {
  //for (int i = 0; i < weeks.length; i++) {
  //  weeks[5].display();
  //}
  screenDraw(screenNum);
}

void screenDraw(int pointer) {
  switch(pointer) {
  case 0 :
    weeks[0].display();
    println("CASE 0");
    screenDraw(1);
    break;

  case 1 :
    weeks[1].display();
    println("CASE 1");
    break;
  }
}

//// MAXIMUM TEMPERATURE ==================================================================================================================================================================================================================================================================

//// Save the maximum temperatures of the previous days in the past week
//float[] maxTempValues = { daily_calgary_ab_2013.getFloat(day1, 7), daily_calgary_ab_2013.getFloat(day2, 7), daily_calgary_ab_2013.getFloat(day3, 7), daily_calgary_ab_2013.getFloat(day4, 7), daily_calgary_ab_2013.getFloat(day5, 7), daily_calgary_ab_2013.getFloat(day6, 7), daily_calgary_ab_2013.getFloat(day7, 7)};
////println(maxTempValues);

//// Minimum maximum temperature for the week
//float maxTempMin = min(maxTempValues);
////println("Week " + currentWeek + " Min Max Temp: " + maxTempMin);

//// Maximum maximum temperature for the week
//float maxTempMax = max(maxTempValues);
////println("Week " + currentWeek + " Max Max Temp: " + maxTempMax);

//// Maximum temperature range for the week
//float maxTempRange = maxTempMax-maxTempMin;
////println("Week " + currentWeek + " Max Temp Range: " + maxTempRange);

//// +1 to either PROG or RETRO depending on minimum maximum temperature
//if (maxTempMin < 0.0 || maxTempMin > 40.0) {
//  retro++;
//  //println("RETRO: maxTempMin");
//} else if ((maxTempMin > 0.0 && maxTempMin < 10.0) || (maxTempMin > 30.0 && maxTempMin < 40.0)) {
//  //println("STAG: maxTempMin");
//} else if (maxTempMin > 10.0 && maxTempMin < 30.0) {
//  prog++;
//  //println("PROG: maxTempMin");
//} else {
//  //println("NAN: maxTempMin");
//}

//// +1 to either PROG or RETRO depending on maximum maximum temperature
//if (maxTempMax < 0.0 || maxTempMax > 40.0) {
//  retro++;
//  //println("RETRO: maxTempMax");
//} else if ((maxTempMax > 0.0 && maxTempMax < 10.0) || (maxTempMax > 30.0 && maxTempMax < 40.0)) {
//  //println("STAG: maxTempMax");
//} else if (maxTempMax > 10.0 && maxTempMax < 30.0) {
//  prog++;
//  //println("PROG: maxTempMax");
//} else {
//  //println("NAN: maxTempMax");
//}

//// +1 to either PROG or RETRO depending on the range of maximum temperature
//if (maxTempRange > 14.0) {
//  retro++;
//  //println("RETRO: maxTempRange");
//} else if (maxTempRange < 7.0) {
//  //println("STAG: maxTempRange");
//} else if (maxTempRange > 7.0 && maxTempRange < 14.0) {
//  prog++;
//  //println("PROG: maxTempRange");
//} else {
//  //println("NAN: maxTempRange");
//}

//// MEAN (AVERAGE) TEMPERATURE ==================================================================================================================================================================================================================================================================

//// Save the mean temperatures of the previous days in the past week
//float[] meanTempValues = { daily_calgary_ab_2013.getFloat(day1, 9), daily_calgary_ab_2013.getFloat(day2, 9), daily_calgary_ab_2013.getFloat(day3, 9), daily_calgary_ab_2013.getFloat(day4, 9), daily_calgary_ab_2013.getFloat(day5, 9), daily_calgary_ab_2013.getFloat(day6, 9), daily_calgary_ab_2013.getFloat(day7, 9)};
////println(meanTempValues);

//// Minimum mean temperature for the week
//float meanTempMin = min(meanTempValues);
////println("Week " + currentWeek + " Min Mean Temp: " + meanTempMin);

//// Maximum mean temperature for the week
//float meanTempMax = max(meanTempValues);
////println("Week " + currentWeek + " Max Mean Temp: " + meanTempMax);

//// Mean temperature range for the week
//float meanTempRange = meanTempMax-meanTempMin;
////println("Week " + currentWeek + " Mean Temp Range: " + meanTempRange);

//// +1 to either PROG or RETRO depending on minimum mean temperature
//if (meanTempMin < 0.0 || meanTempMin > 40.0) {
//  retro++;
//  //println("RETRO: meanTempMin");
//} else if ((meanTempMin > 0.0 && meanTempMin < 10.0) || (meanTempMin > 30.0 && meanTempMin < 40.0)) {
//  //println("STAG: meanTempMin");
//} else if (maxTempMin > 10.0 && maxTempMin < 30.0) {
//  prog++;
//  //println("PROG: meanTempMin");
//} else {
//  //println("NAN: meanTempMin");
//}

//// +1 to either PROG or RETRO depending on maximum mean temperature
//if (meanTempMax < 0.0 || meanTempMax > 40.0) {
//  retro++;
//  //println("RETRO: meanTempMax");
//} else if ((meanTempMax > 0.0 && meanTempMax < 10.0) || (meanTempMax > 30.0 && meanTempMax < 40.0)) {
//  //println("STAG: meanTempMax");
//} else if (meanTempMax > 10.0 && meanTempMax < 30.0) {
//  prog++;
//  //println("PROG: meanTempMax");
//} else {
//  //println("NAN: meanTempMax");
//}

//// +1 to either PROG or RETRO depending on the range of mean temperature
//if (meanTempRange > 14.0) {
//  retro++;
//  //println("RETRO: meanTempRange");
//} else if (meanTempRange < 7.0) {
//  //println("STAG: meanTempRange");
//} else if (meanTempRange > 7.0 && meanTempRange < 14.0) {
//  prog++;
//  //println("PROG: meanTempRange");
//} else {
//  //println("NAN: meanTempRange");
//}

//// TOTAL RAIN ==================================================================================================================================================================================================================================================================

//// Save the rain total of the previous days in the past week
//float[] rainValues = { daily_calgary_ab_2013.getFloat(day1, 15), daily_calgary_ab_2013.getFloat(day2, 15), daily_calgary_ab_2013.getFloat(day3, 15), daily_calgary_ab_2013.getFloat(day4, 15), daily_calgary_ab_2013.getFloat(day5, 15), daily_calgary_ab_2013.getFloat(day6, 15), daily_calgary_ab_2013.getFloat(day7, 15)};
////println(rainValues);

//// Minimum rain total temperature for the week
//float rainMin = min(rainValues);
////println("Week " + currentWeek + " Min Rain: " + rainMin);

//// Maximum rain total temperature for the week
//float rainMax = max(rainValues);
////println("Week " + currentWeek + " Max Rain: " + meanTempMax);

//// Rain total range for the week
//float rainRange = rainMax-rainMin;
////println("Week " + currentWeek + " Rain Range: " + rainRange);

//// +1 to either PROG or RETRO depending on minimum rain amount
//if (rainMin == 0.0 || rainMin > 30.0) {
//  retro++;
//  //println("RETRO: rainMin");
//} else if (rainMin > 0.0 && rainMin < 30.0) {
//  prog++;
//  //println("PROG: rainMin");
//} else {
//  //println("NAN: rainMin");
//}

//// +1 to either PROG or RETRO depending on maximum rain amount
//if (rainMax == 0.0 || rainMax > 30.0) {
//  retro++;
//  //println("RETRO: rainMax");
//} else if (rainMax > 0.0 && rainMax < 30.0) {
//  prog++;
//  //println("PROG: rainMax");
//} else {
//  //println("NAN: rainMax");
//}

//// +1 to either PROG or RETRO depending on the range of rain amount
//if (rainRange == 0.0 || rainRange > 30.0) {
//  retro++;
//  //println("RETRO: rainRange");
//} else if (rainRange > 0.0 && rainRange < 30.0) {
//  prog++;
//  //println("PROG: rainRange");
//} else {
//  //println("NAN: rainRange");
//}

//// TOTAL SNOW ==================================================================================================================================================================================================================================================================

//// Save the snow total of the previous days in the past week
//float[] snowValues = { daily_calgary_ab_2013.getFloat(day1, 17), daily_calgary_ab_2013.getFloat(day2, 17), daily_calgary_ab_2013.getFloat(day3, 17), daily_calgary_ab_2013.getFloat(day4, 17), daily_calgary_ab_2013.getFloat(day5, 17), daily_calgary_ab_2013.getFloat(day6, 17), daily_calgary_ab_2013.getFloat(day7, 17)};
////println(snowValues);

//// Minimum snow total for the week
//float snowMin = min(snowValues);
////println("Week " + currentWeek + " Min Snow: " + snowMin);

//// Maximum snow total for the week
//float snowMax = max(snowValues);
////println("Week " + currentWeek + " Max Snow: " + snowMax);

//// Snow total range for the week
//float snowRange = snowMax-snowMin;
////println("Week " + currentWeek + " Snow Range: " + snowRange);

//// +1 to either PROG or RETRO depending on minimum snow amount
//if (snowMin > 5.0) {
//  retro++;
//  //println("RETRO: snowMin");
//} else if (snowMin > 0.0 && snowMin < 5.0) {
//  //println("STAG: snowMin");
//} else if (snowMin == 0.0) {
//  prog++;
//  //println("PROG: snowMin");
//} else {
//  //println("NAN: snowMin");
//}

//// +1 to either PROG or RETRO depending on maximum snow amount
//if (snowMax > 5.0) {
//  retro++;
//  //println("RETRO: snowMax");
//} else if (snowMax > 0.0 && snowMax < 5.0) {
//  //println("STAG: snowMax");
//} else if (snowMax == 0.0) {
//  prog++;
//  //println("PROG: snowMax");
//} else {
//  //println("NAN: snowMax");
//}

//// +1 to either PROG or RETRO depending on the range of snow amount
//if (snowRange > 5.0) {
//  retro++;
//  //println("RETRO: snowRange");
//} else if (snowRange > 0.0 && snowRange < 5.0) {
//  //println("STAG: snowRange");
//} else if (snowRange == 0.0) {
//  prog++;
//  //println("PROG: snowRange");
//} else {
//  //println("NAN: snowRange");
//}

//// SPEED OF MAX GUST ==================================================================================================================================================================================================================================================================

//// Save the speed of max gust of the previous days in the past week
//float[] speedMaxGustValues = { daily_calgary_ab_2013.getFloat(day1, 25), daily_calgary_ab_2013.getFloat(day2, 25), daily_calgary_ab_2013.getFloat(day3, 25), daily_calgary_ab_2013.getFloat(day4, 25), daily_calgary_ab_2013.getFloat(day5, 25), daily_calgary_ab_2013.getFloat(day6, 25), daily_calgary_ab_2013.getFloat(day7, 25)};
////println(speedMaxGustValues);

//// Minimum speed of max gust for the week
//float speedMaxGustMin = min(speedMaxGustValues);
////println("Week " + currentWeek + " Min Speed of Max Gust: " + speedMaxGustMin);

//// Maximum speed of max gust for the week
//float speedMaxGustMax = max(speedMaxGustValues);
////println("Week " + currentWeek + " Max Speed of Max Gust: " + speedMaxGustMax);

//// Speed of max gust range for the week
//float speedMaxGustRange = speedMaxGustMax-speedMaxGustMin;
////println("Week " + currentWeek + " Speed of Max Gust Range: " + speedMaxGustRange);

//// +1 to either PROG or RETRO depending on minimum speed of max gust
//if (speedMaxGustMin > 35.0) {
//  retro++;
//  //println("RETRO: speedMaxGustMin");
//} else if (speedMaxGustMin == 0.0 || speedMaxGustMin < 35.0) {
//  prog++;
//  //println("PROG: speedMaxGustMin");
//} else {
//  //println("NAN: speedMaxGustMin");
//}

//// +1 to either PROG or RETRO depending on maximum speed of max gust
//if (speedMaxGustMax > 35.0) {
//  retro++;
//  //println("RETRO: speedMaxGustMax");
//} else if (speedMaxGustMax == 0.0 || speedMaxGustMax < 35.0) {
//  prog++;
//  //println("PROG: speedMaxGustMax");
//} else {
//  //println("NAN: speedMaxGustMax");
//}

//// +1 to either PROG or RETRO depending on the range of speed of max gust
//if (speedMaxGustRange > 35.0) {
//  retro++;
//  //println("RETRO: speedMaxGustRange");
//} else if (speedMaxGustRange == 0.0 || speedMaxGustRange < 35.0) {
//  prog++;
//  //println("PROG: speedMaxGustRange");
//} else {
//  //println("NAN: speedMaxGustRange");
//}
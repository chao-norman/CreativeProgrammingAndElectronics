/*
 Inspiration: 
 - I took inspiration from the example we discussed in class with the colored bar
 that rotated clockwise while switching colors. 
 - This program extends off of that particular example from class, where we learned
 about the frameCount built-in function.
 - This program fills the screen with clocks that tick 0.5 times slower than an 
 actual clock. This is supposed to represent how time may have felt like it slowed 
 down during this shelter-in-place due to the fatige everyone is feeling from 
 staying indoors all day.
 */

// function to draw clock hands
void drawClockHand(int handPos, int handWidth, int handHeight) {
  for (int clockX = 100; clockX <= width + 100; clockX += 200) {
    for (int clockY = 100; clockY <= height + 100; clockY += 200) {
      fill(clockX * 2 % 255, clockY * 3 % 255, 
        clockX + clockY * 5 % 255);
      pushMatrix();
      translate(clockX, clockY);
      rotate(radians(handPos) + 55);
      rect(0, 0, handWidth, handHeight);
      popMatrix();
    }
  }
}

void setup() {
  size(1200, 800);
  smooth();
  noStroke();

  // draws the background checkboard pattern
  for (int yPos = 0; yPos <= width+200; yPos += 200) {
    for (int xPos = 0; xPos <= height+200; xPos += 200) {

      // decide whether to use black or grey
      if ((yPos + xPos) % 400 == 0) {
        fill(186, 186, 186);
      } else {
        fill(40, 40, 40);
      }
      rect(xPos, yPos, 200, 200);
    }
  }

  // draws all the clock faces so they're static during animation
  for (int clockX = 100; clockX <= width + 100; clockX += 200) {
    for (int clockY = 100; clockY <= height + 100; clockY += 200) {

      // draws outer ring of each clock
      fill(255, 255, 255);
      stroke(0, 0, 0);
      smooth();
      pushMatrix();
      translate(clockX, clockY);
      circle(0, 0, 200);

      // draws ticks on clock faces
      fill(0, 0, 0);
      for (int clockTick = 0; clockTick <= 12; clockTick += 1) {
        rotate(radians(45 * clockTick));
        rect(0, 85, 3, 10);
      }
      popMatrix();
    }
  }
}

int secondHandPos = 0;
int minuteHandPos = 0;
int hourHandPos = 0;

void draw() {

  // on frame right before clock hand update, clear previous hand
  if (frameCount % 20 == 19) {
    setup();
  }

  // every 20th frame, update clock hands
  if (frameCount % 20 == 0) {

    // draws clock second hand
    drawClockHand(secondHandPos, 70, 2);

    // draw clock minute hand
    drawClockHand(minuteHandPos, 60, 3);

    // draw clock hour hand
    drawClockHand(hourHandPos, 50, 4);

    // check if move minute hand
    if (frameCount % 600 == 0) {
      minuteHandPos += 6;
    }

    // check if move hour hand
    if (frameCount % 3000 == 0) {
      hourHandPos += 6;
    }
    
    // move second hand
    secondHandPos += 6;
  }

  // limits frame rate to 10 fps to get 1 clock movement per second
  frameRate(10);
}

/*
Methods that draw both objects and background/environments
 */

// draw car depending on curr car location
void drawCar() {
  imageMode(CENTER);

  // frameCount buffer for animation
  if (carBuffer >= 0) {
    image(carSprite[carCurrSprite], carX, carY, 360, 184);
  } else {
    image(carSprite[carCurrSprite], carX, carY - 10, 360, 184);
    if (carBuffer <= -2) {
      carBuffer = 2;
    }
  }

  imageMode(CORNER);
}

// draw background gradient
void drawBackgroundGradient() {
  setGradient(0, height/3, width, height/4, grad3, grad4, Y_AXIS);
  setGradient(0, height/6, width, height/6, grad5, grad3, Y_AXIS);
  setGradient(0, 0, width, height/6, black, grad5, Y_AXIS);
}

// draw the sunset in the background
void drawSunset() {

  fill(249, 92, 251);
  stroke(249, 92, 251);
  radialSunGlow(80, 8);
  circle(width/2, height/2 - sunDisplace, 500);

  // displace sunset every frame for animation  
  if (sunReverseBoolean == false && sunReverseCounter <= 30) {
    sunDisplace += 1;
  } else if (sunReverseBoolean == true && sunReverseCounter <= 30) {
    sunDisplace -= 1;
  }
  sunReverseCounter += 1;
  // reverse sun movement direction after 10f pause at peak and trough
  if (sunReverseCounter == 40) {
    sunReverseCounter = 0;
    sunReverseBoolean = !sunReverseBoolean;
  }
}

// radial glow effect for the sun
// Credit: I referenced a discussion on shine effects on the processing forum for the radial glow function.
// @jeremydouglass example: https://forum.processing.org/two/discussion/19037/star-like-shinning-effect
void radialSunGlow(int size, int steps) {
  pushStyle();
  noStroke();
  for (int i = 0; i < size; i+=steps) {
    fill(249, 92, 251, i);
    circle(width/2, height/2 - sunDisplace, 500+i);
  }
  popStyle();
}

// draw the stars in the background
// Credit: I referenced Clementine Smart's star code https://www.openprocessing.org/sketch/76969/
void drawStars() {
  twinkle();
  for (int i = 0; i < 250; i++) {
    noStroke();
    ellipse(xPos[i], yPos[i], s[i], s[i]);
  }
}

// draw mountains across the horizon upon setup
// Credit: I referenced Michael Pinn's mountain code: https://www.openprocessing.org/sketch/179344
void drawMountains() {
  // draw further away mtn range
  for (int i = 0; i <= 10; i++) {
    float y = i * 30;
    fill(144, 19, 145);
    stroke(144, 19, 145);
    beginShape();
    vertex(0, 500 + y);
    for (int q = 0; q <= width; q += 10) {
      float y2 = 500 + y - abs(sin(radians(q/2) + i)) * cos(radians(i + q/2.5)) * map(i, 0, 5, 25, 30);
      vertex(q, y2);
    }
    vertex(width, height/2);
    vertex(0, height/2);
    endShape(CLOSE);
  }
  // draw close up mtn range
  for (int i = 0; i <= 10; i++) {
    float y = i * 30;
    fill(101, 13, 137);
    stroke(101, 13, 137);
    beginShape();
    vertex(0, 500 + y);
    for (int q = 0; q <= width; q += 10) {
      float y2 = 500 + y - abs(sin(radians(q/2) + i)) * cos(radians(i + q/2.5)) * map(i, 0, 5, 25, 30);
      vertex(q, y2 + 10);
    }
    vertex(width, height/2);
    vertex(0, height/2);
    endShape(CLOSE);
  }
  // need to redraw gradient here to cover bottom of mountains
  setGradient(0, height/2, width, height/4, grad4, grad2, Y_AXIS);
  setGradient(0, height/2 + height/4, width, height, grad2, grad6, Y_AXIS);
}

// draw vertical neon lines on ground
void drawVertLines() {

  strokeWeight(5);
  fill(45, 226, 230);
  stroke(45, 226, 230);

  // left vertical
  float xMult = 1.2;
  float yMult = 1.5;
  for (int x = width / 2 - 100; x >= 0; x -= 100 * xMult) {
    line(x, height/2 - 5, 0, height - 150 * yMult);
    xMult += .2;
    yMult += .5;
  }

  // right vertical
  xMult = 1.2;
  yMult = 1.5;
  for (int x = width / 2 + 100; x <= width; x += 100 * xMult) {
    line(x, height/2 - 5, width, height - 150 * yMult);
    xMult += .2;
    yMult += .5;
  }
}

// draw horizontal lines for title screen
void drawHoriLines() {
  float yMult = 1.5;
  float xMultLeft = 1;
  float xMultRight = 1;
  for (int y = height / 2 + 25; y <= height; y += 50 * yMult) {
    line(0, y, (y - 971) * 172 / 87 * -1 + (35 * xMultLeft), y);
    line((y - 100) * 172 / 87 + (160 * xMultRight), y, width, y);
    yMult *= 1.3;
    xMultLeft -= 0.3;
    xMultRight += 0.08;
  }
}

// draw horizontal neon lines on the ground (for animation)
void drawMovingHoriLines() {
  float yMult = 1.5;
  float xMultLeft = 1;
  float xMultRight = 1;

  if (roadBuffer == 3) {
    for (int y = height / 2 - 75; y <= height; y += 50 * yMult) {
      line(0, y, (y - 971) * 172 / 87 * -1 + (35 * xMultLeft), y);
      line((y - 100) * 172 / 87 + (160 * xMultRight), y, width, y);
      yMult *= 1.3;
      xMultLeft -= 0.3;
      xMultRight += 0.08;
    }
  } else if (roadBuffer == 2) {
    for (int y = height / 2 - 25; y <= height; y += 50 * yMult) {
      line(0, y, (y - 971) * 172 / 87 * -1 + (35 * xMultLeft), y);
      line((y - 100) * 172 / 87 + (160 * xMultRight), y, width, y);
      yMult *= 1.3;
      xMultLeft -= 0.3;
      xMultRight += 0.08;
    }
  } else if (roadBuffer == 1) {
    for (int y = height / 2 + 25; y <= height; y += 50 * yMult) {
      line(0, y, (y - 971) * 172 / 87 * -1 + (35 * xMultLeft), y);
      line((y - 100) * 172 / 87 + (160 * xMultRight), y, width, y);
      yMult *= 1.3;
      xMultLeft -= 0.3;
      xMultRight += 0.08;
    }
  } else {
    for (int y = height / 2 + 75; y <= height; y += 50 * yMult) {
      line(0, y, (y - 971) * 172 / 87 * -1 + (35 * xMultLeft), y);
      line((y - 100) * 172 / 87 + (160 * xMultRight), y, width, y);
      yMult *= 1.3;
      xMultLeft -= 0.3;
      xMultRight += 0.08;
    }
  }
  if (roadBuffer <= 0) {
    roadBuffer = 2;
  }
}

// draw road
void drawRoad() {
  stroke(24, 24, 89);
  fill(24, 24, 89);
  quad(width/2 - 50, height/2, width/2 + 50, height/2, width + 200, height, 0 - 200, height);
}

// draw road lines
void drawRoadLines() {

  strokeWeight(6);
  stroke(254, 219, 255, 250);
  line(width/2 - 50, height/2 - 3, 0, height - 100);
  line(width/2 + 50, height/2 - 3, width, height - 100);

  strokeWeight(4);
  fill(251, 179, 253);
  stroke(251, 179, 253);
  line(width/2 - 50, height/2 - 3, 0, height - 100);
  line(width/2 + 50, height/2 - 3, width, height - 100);

  strokeWeight(3);
  fill(251, 179, 253);
  stroke(251, 179, 253);
  line(width/2 - 10, height/2, width/2 - 350, height);
  line(width/2 + 10, height/2, width/2 + 350, height);
}

// use linear interpolation to draw gradients
// Credit: I referenced linear gradient example on the Processing website: https://processing.org/examples/lineargradient.html
void setGradient(int x, int y, float w, float h, color c1, color c2, int axis) {

  noFill();  

  // top to bottom gradient
  if (axis == Y_AXIS) {
    for (int i = y; i <= y + h; i++) {
      float inter = map(i, y, y+h, 0, 1); 
      color c = lerpColor(c1, c2, inter); 
      stroke(c); 
      line(x, i, x+w, i);
    }
  } 

  // left to right gradient
  else if (axis == X_AXIS) {
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1); 
      color c = lerpColor(c1, c2, inter); 
      stroke(c); 
      line(i, y, i, y+h);
    }
  }
}

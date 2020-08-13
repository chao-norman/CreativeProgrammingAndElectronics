/*
Methods to load files or entities into the game during setup and stage changes.
 */

// Load game files during setup
void loadGameFiles() {

  // PLEASE UPDATE THESE FILE PATHS IF YOU WANT TO LOAD THE GAME ON YOUR OWN COMPUTER
  titleLogo = loadImage("C:/Users/ChaoN/Desktop/des inv 23/Sunset_Cruise/assets/title_logo.png");
  playButton = loadImage("C:/Users/ChaoN/Desktop/des inv 23/Sunset_Cruise/assets/play_button.png");
  font = createFont("YU Gothic UI Bold", 32);

  // load car sprites
  for (int i = 0; i <= 8; i++) {
    carSprite[i] = loadImage("C:/Users/ChaoN/Desktop/des inv 23/Sunset_Cruise/assets/" + str(i) + ".png");
  }

  // load radio songs
  for (int i = 0; i < 7; i++) {
    radioMusic[i] = new SoundFile(this, "C:/Users/ChaoN/Desktop/des inv 23/Sunset_Cruise/assets/songs/" + str(i) + ".mp3");
  }
}

// load random configuration of twinkling stars during setup
// Credit: I referenced Clementine Smart's star code: https://www.openprocessing.org/sketch/76969/
void loadStars() {

  for (int i = 0; i < 250; i++) {
    xPos[i] = random(1, 1920);
    yPos[i] = random(1, height/2);
    xVel[i] = random(-10, 10);
    yVel[i] = random(-10, 10);
    s[i] = random(1, 6);
  }
}


// helper method for star animation
// Credit: Clementine Smart star tracker code: https://www.openprocessing.org/sketch/76969/
void twinkle() {
  smooth();
  noStroke();
  line(a, b, c, a);
  a = a + 3;
  if (a == 600) {
    a = 0;
    c += 100;
    b += 100;
  }
  stroke(255);
  for (int i = 0; i < 250; i++) {
    line (xPos[i]+p, yPos[i], xPos[i], yPos[i]);
    line (xPos[i], yPos[i]+p, xPos[i], yPos[i]);
    line (xPos[i], yPos[i], xPos[i]-p, yPos[i]);
    line (xPos[i], yPos[i], xPos[i], yPos[i]-p);
    if (a > yPos[i]-25)
      p = 5;
    if (a < yPos[i]+25)
      p = 5;
    if (a < yPos[i]-25)
      p = 0;
    if (a > yPos[i]+25)
      p = 0;
    i = i + 1;
  }
}

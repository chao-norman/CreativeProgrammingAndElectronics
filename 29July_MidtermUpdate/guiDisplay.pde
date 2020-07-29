/*
Methods to display the user interface
 */

// displays the menu screen
void displayMenu() {
  // play menu music
  if (menuMusicPlaying == false) {
    menuMusic.loop(1, 0.1);
    menuMusicPlaying = true;
  }

  // display background and menu buttons
  image(background, 0, 0);
  displayTitle();
  playButton(width, height);
}

//displays title
void displayTitle() {
  imageMode(CENTER);
  image(titleImg, width/2 + 10, height/3, 672, 400);
}

// display instructions for the game at bottom of screen
void displayInstructions() {
  textFont(font, 28);
  textAlign(CENTER);
  fill(0, 0, 0);
  text("[ HOW TO PLAY ]: Use ARROW-KEYS to move | Click SPACEBAR to throw ball | Press P to pause", width/2, height-50);
  fill(255, 188, 43);
  text("[ HOW TO PLAY ]: Use ARROW-KEYS to move | Click SPACEBAR to throw ball | Press P to pause", width/2 - 1, height-50-1);
}


// displays play button with dimensions w x h
void playButton(float w, float h) {
  imageMode(CENTER);
  image(playButton, w/2, h-(h/4), buttonWidth, buttonHeight);

  // display font for play button
  textFont(font, 50);
  textAlign(CENTER);
  fill(230, 115, 0);
  text("PLAY", w/2, h-(h/4.3));
  fill(255, 243, 150);
  text("PLAY", w/2 - 1, h-(h/4.3) - 1);

  // display instructions whenever the play button is being shown
  displayInstructions();

  // reset image mode to default
  imageMode(CORNER);
}

// displays the number of balls that you have available to throw
void displayBallStock() {
  textFont(font, 32);
  textAlign(CORNER);
  fill(0, 0, 0);
  text("# Balls: ", 9, 101);
  fill(255, 188, 43);
  text("# Balls: ", 8, 100);

  int firstBallX = 120;
  for (int i = 0; i < ballStock; i++) {
    image(ballStockSprite, firstBallX, 80, 25, 25);
    firstBallX += 40;
  }
}

// display player health at top-left corner during game
void displayHealth() {
  textFont(font, 32);
  textAlign(CORNER);
  fill(0, 0, 0);
  text("Health: ", 9, 68);
  fill(255, 188, 43);
  text("Health: ", 8, 67);
  image(playerHealthSprite[playerHealthSpriteNum], 120, 45, 190, 25);
}

// Display score at top-left corner during game or center of screen when lost
void displayScore(String location) {

  fill(0, 0, 0);
  // if game still playing, display score at top left corner
  if (location == "topLeft") {
    textFont(font, 32);
    textAlign(CORNER);
    text("Score: " + str(score), 9, 33);
    fill(255, 188, 43);
    text("Score: " + str(score), 8, 32);
    // if player lost, display score at center and high score below it
  } else if (location == "center") {
    textFont(font, 50);
    textAlign(CENTER);
    text("Score: " + str(score), width/2, height/2);
    fill(255, 188, 43);
    text("Score: " + str(score), width/2 - 1, height/2 - 1);

    // check for and display high score
    if (score > highScore) {
      highScore = score;
    }
    fill(0, 0, 0);
    textFont(font, 40);
    text("High Score: " + str(highScore), width/2, height/2 + 70);
    fill(255, 188, 43);
    text("High Score: " + str(highScore), width/2 - 1, height/2 + 70 - 1);

    // display play button to reload game
    playButton(width, height);
  }
}

// writes to arduino to display the correct LED color
void writeToArduinoLed() {
  if (matrixState == 0) {
    port.write('R');
  } else if (matrixState == 1) {
    port.write('Y');
  } else if (matrixState == 2) {
    port.write('G');
  }
}

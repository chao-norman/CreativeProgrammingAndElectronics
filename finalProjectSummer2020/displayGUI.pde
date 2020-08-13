/*
Methods that display/interact with the GUI
 */

// displays play button with dimensions w x h
void displayPlayButton() {
  imageMode(CENTER);
  image(playButton, width/2, height/2 + 340, 87.15, 89.775);

  // display instructions whenevter the play button is being shown
  displayInstructions();

  // reset image mode to default
  imageMode(CORNER);
}

// display title logo during title screen
void displayTitleLogo() {
  imageMode(CENTER);
  image(titleLogo, width/2, height/2 - titleDisplace, 734.4, 498.1);

  // displace title logo every frame for animated effect
  if (titleReverseBoolean == false && titleReverseCounter <= 10) {
    titleDisplace += 0.5;
  } else if (titleReverseBoolean == true && titleReverseCounter <= 10) {
    titleDisplace -= 0.5;
  }
  titleReverseCounter += 0.5;
  // reverse title movement direction after 5f pause at peak and trough
  if (titleReverseCounter == 13) {
    titleReverseCounter = 0;
    titleReverseBoolean = !titleReverseBoolean;
  }
}

// display instructions for the game beneath the play button
void displayInstructions() {
  textFont(font, 28);
  textAlign(CENTER);
  fill(0, 0, 0);
  text("Relax. Breathe. Clear your thoughts. Enjoy the ride. Everything will be alright.", width/2, height/2 + 450);
  fill(255, 188, 43);
  text("Relax. Breathe. Clear your thoughts. Enjoy the ride. Everything will be alright.", width/2 - 1, height/2 + 450);
}

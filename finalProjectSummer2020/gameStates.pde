/*
Methods for each of the game states
 */

// Title Screen (gameState = 0)
void titleScreen() {
  // drawing background
  drawBackgroundGradient();
  drawSunset();
  drawStars();
  drawMountains();
  drawVertLines();
  drawHoriLines();
  drawRoad();
  drawRoadLines();

  // display GUI
  displayTitleLogo();
  displayPlayButton();
}

// Game In Progress (gameState = 1)
void gameInProgress() {
  // drawing background
  drawBackgroundGradient();
  drawSunset();
  drawStars();
  drawMountains();
  drawVertLines();
  drawMovingHoriLines();
  drawRoad();
  drawRoadLines();

  // draw entities
  drawCar();
}

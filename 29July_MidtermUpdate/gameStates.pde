/*
Methods that change the game state.
 (eg. goes to the next stage, ends the game, etc.)
 */

// starts the next stage
void nextStage() {
  enemyBalls = new ArrayList<Ball>();
  playerBalls = new ArrayList<Ball>();
  enemyHit = 0;
  enemyNum++;
  enemySpd += 0.25;
  if (enemyNum % 5 == 0) {
    playerSpd++;
  }
  // Load enemies for start of next round
  loadBunnies();
}

// ends the game
void endGame() {
  image(background, 0, 0);
  image(playerSprite[currSprite], playerX, playerY, playerWidth, playerHeight);
  if (gameMusicPlaying == true) {
    gameMusic.stop();
    gameMusic.play(0.75, 0.035);
    gameMusicPlaying = false;
  }
  updatePlayerSprite();
  displayScore("center");
}

// loads default game settings
void loadDefaultSettings() {

  // player variables
  playerHealth = 100;
  playerSpd = 5;
  score = 0;

  // enemy variables
  enemyNum = 2;
  enemyHit = enemyNum;
  enemySpd = 0.5;
  // float enemyBallSpd = 5; // shoot ball at player direction, without ballDir variable

  // game variables
  playerHealthSpriteNum = 0;
}

// update matrix state as the game is being played
void updateMatrixState() {
  if (frameCount % 360 == 0 && matrixState < 2) {
    matrixState += 1;
  }
}

// activates matrix mode if button was pressed on arduino
void activateMatrixMode() {
  if (matrixTimer == 300) {
    ballSpd = 20;
    ballStock = 10;
    ballReloadTimer = 5;
    ballRefreshTimer = 10;
    playerInvincible = 1;
    enemySpd /= 4;
    playerSpd *= 2;
    gameMusic.stop();
    gameMusic.loop(1.5, 0.03);
  } else if (matrixTimer == 1) {
    ballSpd = 10;
    ballStock = 5;
    ballReloadTimer = 60;
    ballRefreshTimer = 120;
    playerInvincible = 0;
    enemySpd *= 4;
    playerSpd /= 2;
    gameMusic.stop();
    gameMusic.loop(0.9, 0.03);
  }
}

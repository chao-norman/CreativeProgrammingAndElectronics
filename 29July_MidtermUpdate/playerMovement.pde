/*
Methods to control player movement.
 */

// captures mouse button press
public void mousePressed() {
  if (mouseButton == LEFT) {

    // if player presses the play button area, then start the game
    if (mouseX > width/2 - buttonWidth/2 && 
      mouseX < width/2 + buttonWidth/2 && 
      mouseY > height-(height/4) - buttonHeight/2 && 
      mouseY < height-(height/4) + buttonHeight/2 &
      playerHealth <= 0) {

      playButtonHit = true;
      loadDefaultSettings();

      // show visual of button being clicked 
      image(background, 0, 0);
      playButton(width, height + 15);
    }
  }
}

// captures key presses
public void keyPressed() {
  if (keyCode == UP)
    upPressed = true;
  if (keyCode == DOWN)
    downPressed = true;
  if (keyCode == LEFT)
    leftPressed = true;
  if (keyCode == RIGHT)
    rightPressed = true;
  if (key == ' ')
    spacePressed = true;

  // adds pause button to the game
  if (key == 'p') {
    if (gamePaused == false) {
      gamePaused = true;
      noLoop();
    } else if (gamePaused == true) {
      gamePaused = false;
      loop();
    }
  }
}

// captures key releases
public void keyReleased() {
  if (keyCode == UP)
    upPressed = false;
  if (keyCode == DOWN)
    downPressed = false;
  if (keyCode == LEFT)
    leftPressed = false;
  if (keyCode == RIGHT)
    rightPressed = false;
}

// updates player movement based on key presses and key releases
public void updatePlayerPosition() {
  if (upPressed && playerY > 0) 
    playerY -= playerSpd;
  if (downPressed && playerY < height - playerHeight)
    playerY += playerSpd;
  if (leftPressed && playerX > 0)
    playerX -= playerSpd;
  if (rightPressed && playerX < width - playerWidth)
    playerX += playerSpd;
}

// updates player movement direction to determine ball direction
public void playerMoveDir() {
  if (upPressed && leftPressed && !rightPressed && !downPressed)
    ballDir = "topLeft";
  if (upPressed && rightPressed && !downPressed && !leftPressed)
    ballDir = "topRight";
  if (downPressed && leftPressed && !upPressed && !rightPressed)
    ballDir = "bottomLeft";
  if (downPressed && rightPressed && !upPressed && !leftPressed)
    ballDir = "bottomRight";
  if (upPressed && !leftPressed && !rightPressed && !downPressed)
    ballDir = "top";
  if (downPressed && !upPressed && !leftPressed && !rightPressed)
    ballDir = "bottom";
  if (leftPressed && !upPressed && !rightPressed && !downPressed)
    ballDir = "left";
  if (rightPressed && !leftPressed && !upPressed && !downPressed)
    ballDir = "right";
}

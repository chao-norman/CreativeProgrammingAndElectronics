/*
Methods to update the position/variables of entities.
 */

// Updates the position of bunnies
void updateBunnies() {
  for (Bunny bunny : bunnies) {
    if (!bunny.dead) {
      bunny.drawBunny();
    } else {
      // moving them off the canvas so they aren't an invisible obstacle
      bunny.bunnyX = -99999999;
      bunny.bunnyY = -99999999;
    }
  }
}

// Updates the position of the balls and adds 1 ball to stock every 1.5 seconds (90 frames)
void updateBalls() {

  // throw player ball if spacebar is pressed (initializes player ball)
  if (spacePressed && ballStock > 0) {
    loadPlayerBall();
  } else {
    spacePressed = false;
  }

  // reload all balls in player's stock if no more balls after 1 second delay
  if (ballStock <= 0) {
    if (ballReloadTimer <= 0) {
      ballReloadTimer = 60;
      ballRefreshTimer = 120;
      ballStock += 5;
      ballReloadSound.play(1, 0.1);
    } else {
      ballReloadTimer--;
    }
  }

  // refresh all balls in player's stock if they haven't shot a ball in 2 seconds
  if (ballStock < 5) {
    if (ballRefreshTimer <= 0) {
      ballRefreshTimer = 120;
      ballStock = 5;
      ballReloadSound.play(1, 0.1);
    } else {
      ballRefreshTimer--;
    }
  }

  // goes through each initialized player ball and udpates position
  for (Ball ball : playerBalls) {
    ball.drawBall();
  }

  // goes through each enemy ball and updates position
  for (Ball ball : enemyBalls) {
    ball.drawBall();
  }
}

// Updates the position of the player and lowers damage buffer
void updatePlayer() {
  updatePlayerPosition();
  image(playerSprite[currSprite], playerX, playerY, playerWidth, playerHeight);
  updatePlayerSprite();

  // lowers damage buffer by 1 every frame; player can only take damage at 0
  if (playerDamageBuffer > 0) {
    playerDamageBuffer -= 1;
  }
}

// update player health (because they got hit by an enemy or a projectile)
void updatePlayerHealth() {
  playerHitSound.play(1, 0.25);
  playerHealth -= 25;
  playerHealthSpriteNum += 1;
  playerDamageBuffer = 60;

  // redraw background to subtly flash screen to indicate the player took damage
  image(background, 0, 0);
}

// Update player to next sprite (for animation)
void updatePlayerSprite() {
  if (frameCount % 20 == 0) {
    currSprite++;
    if (currSprite > 1) {
      currSprite = 0;
    }
  }
}

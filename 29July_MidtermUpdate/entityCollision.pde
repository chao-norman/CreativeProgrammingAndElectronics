/*
Methods to check for collisions between entities and act accordingly.
 (eg. reduce enemy health, reduce player health, etc.)
 */

void checkCollision() {

  // Check for collision between player-to-bunnies and playerBalls-to-bunnies
  for (Bunny b : bunnies) {
    boolean topLeftCollision = playerX + playerWidth - collisionBuffer > b.bunnyX && 
      playerY + playerHeight - collisionBuffer > b.bunnyY;
    boolean topRightCollision = playerX + collisionBuffer < b.bunnyX + b.bunnyWidth && 
      playerY + playerHeight - collisionBuffer > b.bunnyY;
    boolean bottomLeftCollision = playerX + playerWidth - collisionBuffer > b.bunnyX && 
      playerY + collisionBuffer < b.bunnyY + b.bunnyHeight;
    boolean bottomRightCollision = playerX + collisionBuffer < b.bunnyX + b.bunnyWidth && 
      playerY + collisionBuffer < b.bunnyY + b.bunnyHeight;

    // if all of these conditions are true, player is touching bunny
    if (topLeftCollision && topRightCollision && bottomLeftCollision && bottomRightCollision) {
      if (playerDamageBuffer == 0 && playerInvincible == 0) {
        updatePlayerHealth();
      }
    }
    for (Ball ball : playerBalls) {
      boolean topLeftBallHit = ball.ballX + ball.ballWidth > b.bunnyX && ball.ballY + ball.ballHeight > b.bunnyY;
      boolean topRightBallHit = ball.ballX < b.bunnyX + b.bunnyWidth && ball.ballY + ball.ballHeight > b.bunnyY;
      boolean bottomLeftBallHit = ball.ballX + ball.ballWidth > b.bunnyX && ball.ballY < b.bunnyY + b.bunnyHeight;
      boolean bottomRightBallHit = ball.ballX < b.bunnyX + b.bunnyWidth && ball.ballY < b.bunnyY + b.bunnyHeight;

      // if all of these conditions are true, this bunny 'b' is hit by a ball
      if (topLeftBallHit && topRightBallHit && bottomLeftBallHit && bottomRightBallHit 
        && b.bunnyHealth > 0 && b.bunnyDamageBuffer <= 0) {
        enemyHitSound.play(1, 0.5);
        b.bunnyHealth -= 25;
        if (b.currHealthSprite < 2) {
          b.currHealthSprite++;
        }
        b.bunnyDamageBuffer = 20;
        if (b.bunnyHealth <= 0) {
          b.dead = true;
          enemyHit++;
          score++;
        }
      }
    }
  }

  // check for collision between player and throwerBunny balls
  for (Ball ball : enemyBalls) {
    boolean topLeftBallHit = ball.ballX + ball.ballWidth > playerX && ball.ballY + ball.ballHeight > playerY;
    boolean topRightBallHit = ball.ballX < playerX + playerWidth && ball.ballY + ball.ballHeight > playerY;
    boolean bottomLeftBallHit = ball.ballX + ball.ballWidth > playerX && ball.ballY < playerY + playerHeight;
    boolean bottomRightBallHit = ball.ballX < playerX + playerWidth && ball.ballY < playerY + playerHeight;

    // if all of these conditions are true, player has been hit with the ball
    if (topLeftBallHit && topRightBallHit && bottomLeftBallHit && bottomRightBallHit 
      && playerDamageBuffer == 0 && playerInvincible == 0) {
      updatePlayerHealth();
    }
  }
}

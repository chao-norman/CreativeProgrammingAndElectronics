/*
Class for the Ball entity that both the player and the enemies throw.
 */

class Ball {

  // Variables -----------------------------------//
  public float ballX;
  public float ballY;
  public float ballWidth;
  public float ballHeight;
  public float xSpd;
  public float ySpd;
  public String ballDir;
  public int currSprite; // decides the next sprite to display
  public String ballType; // stores whether player or enemy threw the ball

  // Constructor ---------------------------------//
  Ball(float xCord, float yCord, float bWidth, float bHeight, float bSpd, String direction, String playerOrEnemyBall, Bunny b) {
    ballX = xCord;
    ballY = yCord;
    ballWidth = bWidth;
    ballHeight = bHeight;
    xSpd = bSpd;
    ySpd = bSpd;
    ballDir = direction;
    ballType = playerOrEnemyBall;

    // apply direction of ball to xSpd and ySpd if player ball
    if (ballType == "player") {
      updateBunnySpd();
    } else if (ballType == "throwerBunny") {
      updateThrowerSpd(b);
    }
  }

  // Functions -----------------------------------//

  // Draws the ball at its next location
  void drawBall() {

    // checks whether this ball belongs to the player or the enemy
    if (ballType == "player") {
      image(playerBallSprite[currSprite], ballX, ballY, ballWidth, ballHeight);
    }
    if (ballType == "throwerBunny") {
      image(enemyBallSprite[currSprite], ballX, ballY, ballWidth, ballHeight);
    }

    // updates next location and next sprite of the ball
    nextLocation();
    nextSprite();
  }

  // Update to next sprite
  void nextSprite() {
    // update ball sprite every 20 frames
    if (frameCount % 5 == 0) {
      currSprite++;
      if (currSprite > 3) {
        currSprite = 0;
      }
    }
  }

  // Update initial speed of the ball based on the initial direction thrown
  void updateBunnySpd() {
    if (ballDir == "topRight") {
      ySpd *= -1;
    }
    if (ballDir == "top") {
      xSpd = 0;
      ySpd *= -1;
    }
    if (ballDir == "topLeft") {
      ySpd *= -1;
      xSpd *= -1;
    }
    if (ballDir == "right") {
      ySpd = 0;
    }
    if (ballDir == "bottom") {
      xSpd = 0;
    }
    if (ballDir == "bottomLeft") {
      xSpd *= -1;
    }
    if (ballDir == "left") {
      xSpd *= -1;
      ySpd *= 0;
    }
  }

  // Update initial speed of the ball based on the bunny position and player position
  void updateThrowerSpd(Bunny b) {
    float distBetweenBunnyAndPlayer = dist(playerX, b.bunnyX, playerY, b.bunnyY);
    if (distBetweenBunnyAndPlayer > width/4) {
      distBetweenBunnyAndPlayer /= 7;
      xSpd = (playerX - b.bunnyX) / distBetweenBunnyAndPlayer;
      ySpd = (playerY - b.bunnyY) / distBetweenBunnyAndPlayer;
    } else {
      distBetweenBunnyAndPlayer /= 6;
      xSpd = (playerX - b.bunnyX) / distBetweenBunnyAndPlayer;
      ySpd = (playerY - b.bunnyY) / distBetweenBunnyAndPlayer;
    }

    // adjusting xSpd and ySpd to make sure ball doesn't lag
    if ((0 <= xSpd && xSpd <= 2 && 0 <= ySpd && ySpd <= 2) || (-2 <= xSpd && xSpd <= 0 && -2 <= ySpd && ySpd <= 0)
      || (0 <= xSpd && xSpd <= 2 && -2 <= ySpd && ySpd <= 0) || (-2 <= xSpd && xSpd <= 0 && 0 <= ySpd && ySpd <= 2)) {

      // adjust xSpd appropriately based on sign
      if (xSpd <= 0) {
        xSpd *= 10;
      } else if (xSpd >= 0) {
        xSpd *= 10;
      }

      // adjust ySpd appropriately based on sign
      if (ySpd <= 0) {
        ySpd *= 10;
      } else if (ySpd >= 0) {
        ySpd *= 10;
      }
    }

    // adjusting xSpd and ySpd to make sure balls aren't going SUPER fast
    if (xSpd >= 20 || xSpd <= 20) {
      xSpd /= 1.5;
    }
    if (ySpd >= 20 || ySpd <= 20) {
      ySpd /= 1.5;
    }
  }

  // Update to next location
  void nextLocation() {
    ballX += xSpd;
    ballY += ySpd;
  }
}

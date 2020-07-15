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
  PImage[] ballSprite = new PImage[4];

  // Constructor ---------------------------------//
  Ball(float xCord, float yCord, float bWidth, float bHeight, float bSpd, String direction) {
    ballX = xCord;
    ballY = yCord;
    ballWidth = bWidth;
    ballHeight = bHeight;
    xSpd = bSpd;
    ySpd = bSpd;
    ballDir = direction;

    // apply direction of ball to xSpd and ySpd
    updateSpd();

    // load all the sprites for the ball
    for (int i = 0; i <= 3; i++) {
      ballSprite[i] = loadImage("C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sprites/ball" + str(i) + ".png");
    }
  }

  // Functions -----------------------------------//

  // Draws the ball at its next location
  void drawBall() {
    image(ballSprite[currSprite], ballX, ballY, ballWidth, ballHeight);
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
  void updateSpd() {
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
    }
  }

  // Update to next location
  void nextLocation() {
    ballX += xSpd;
    ballY += ySpd;
  }
}

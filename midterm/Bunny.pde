/*
Class for the Bunny entity (enemy class).
 */

class Bunny {

  // Variables -----------------------------------//
  public float bunnyX;
  public float bunnyY;
  public float bunnyWidth;
  public float bunnyHeight;
  public float xSpd;
  public float ySpd;
  public boolean dead;
  public float bunnyHealth;
  public boolean throwerBunny;
  public float bunnyDamageBuffer = 0;
  public int currSprite; // decides the next sprite to display
  public int currHealthSprite = 0;
  public int randomShooterInterval;

  // Constructor ---------------------------------//
  Bunny(float xCord, float yCord, float bWidth, float bHeight, float bunnySpd, boolean thrower) {
    bunnyX = xCord;
    bunnyY = yCord;
    xSpd = bunnySpd;
    ySpd = bunnySpd;
    bunnyWidth = bWidth;
    bunnyHeight = bHeight;
    dead = false;
    currSprite = int(random(0, 4));
    throwerBunny = thrower;
    randomShooterInterval = int(random(120, 300));
    if (throwerBunny == true) {
      bunnyHealth = 50;
    } else if (throwerBunny == false) {
      bunnyHealth = 25;
    }

    // set initial direction bunny is going toward
    float coinFlipX = random(-1, 1);
    float coinFlipY = random(-1, 1);
    if (coinFlipX <= 0) {
      xSpd *= -1;
    }
    if (coinFlipY <= 0) {
      ySpd *= -1;
    }
  }

  // Functions -----------------------------------//

  // Draws the bunny at its next location
  void drawBunny() {

    // if bunny is a regular bunny, draw the regular bunny sprite
    if (throwerBunny == false) {
      image(bunnySprite[currSprite], bunnyX, bunnyY, bunnyWidth, bunnyHeight);
      image(enemyHealthSprite[currHealthSprite], bunnyX, bunnyY - 10, bunnyWidth, 5);
    } else if (throwerBunny == true) {
      image(enemyHealthSprite[currHealthSprite], bunnyX, bunnyY - 10, bunnyWidth * 1.25, 5);
      image(throwerBunnySprite[currSprite], bunnyX, bunnyY, bunnyWidth * 1.25, bunnyHeight * 1.25);
    }

    // if bunny is a thrower bunny, throw ball at random interval specified in constructor
    if (throwerBunny == true && frameCount % randomShooterInterval == 0) {
      loadEnemyBall(bunnyX, bunnyY, this);
    }

    bunnyDamageBuffer--;
    nextLocation();
    nextSprite();
  }

  // Update to next sprite
  void nextSprite() {
    // update bunny sprite every 20 frames
    if (frameCount % 20 == 0) {
      currSprite++;
      if (currSprite > 3) {
        currSprite = 0;
      }
    }
  }

  // Update to next location
  void nextLocation() {
    bunnyX += xSpd;
    bunnyY += ySpd;

    // if bunny goes off canvas on x-plane, turn it around
    if (bunnyX < 0 || bunnyX + bunnyWidth > width) {
      xSpd *= -1;
    }

    // if bunny goes off canvas on y-plane, turn it around
    if (bunnyY < 0 || bunnyY + bunnyHeight > height) {
      ySpd *= -1;
    }
  }
}

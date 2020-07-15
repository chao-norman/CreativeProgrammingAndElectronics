class Bunny {

  // Variables -----------------------------------//
  public float bunnyX;
  public float bunnyY;
  public float bunnyWidth;
  public float bunnyHeight;
  public float xSpd;
  public float ySpd;
  public boolean hit;
  public int currSprite; // decides the next sprite to display
  PImage[] bunnySprite = new PImage[4];

  // Constructor ---------------------------------//
  Bunny(float xCord, float yCord, float bWidth, float bHeight, float bunnySpd) {
    bunnyX = xCord;
    bunnyY = yCord;
    xSpd = bunnySpd;
    ySpd = bunnySpd;
    bunnyWidth = bWidth;
    bunnyHeight = bHeight;
    hit = false;
    currSprite = int(random(0, 4));

    // set initial direction bunny is going toward
    float coinFlipX = random(-1, 1);
    float coinFlipY = random(-1, 1);
    if (coinFlipX <= 0) {
      xSpd *= -1;
    }
    if (coinFlipY <= 0) {
      ySpd *= -1;
    }

    // load all the sprites for the bunny
    for (int i = 0; i <= 3; i++) {
      bunnySprite[i] = loadImage("C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sprites/bunny" + str(i) + ".png");
    }
  }

  // Functions -----------------------------------//

  // Draws the bunny at its next location
  void drawBunny() {
    image(bunnySprite[currSprite], bunnyX, bunnyY, bunnyWidth, bunnyHeight);
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
    if (bunnyX < 0 || bunnyX > width) {
      xSpd *= -1;
    }

    // if bunny goes off canvas on y-plane, turn it around
    if (bunnyY < 0 || bunnyY > height) {
      ySpd *= -1;
    }
  }
}

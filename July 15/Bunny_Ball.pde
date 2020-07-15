/*

 This is a game where you're playing dodgeball with bunnies! Except you're the only one throwing balls
 and if you touch the bunnies you instantly lose (at least in this version)! If you manage to hit all the bunnies 
 successfully, you'll advance to the next stage and the difficulty will increase. Try to survive the longest and 
 get the highest score!
 
 Inspiration:
 - I play an iOS/Android game called "Archero" when I'm bored and they're currently having their 1 year anniversary.
 I thought that it might be fun to try and make a "bullet-hell" game similar to Archero. Although the enemies shooting
 bullets might be a bit much for me to do for the first version. I'll add that in the next version!
 
 Timelog:
 - [7/15/20] For now I'm only implementing the player throwing balls and bunnies just running around. I'll
 work on the bunnies throwing the balls in the future when I have more time (and mental capacity).
 
 Credits:
 - I used Pixel Pete's Art Assets which are free to use in anyone's games!
 https://petermilko.itch.io/pixel-petes-art-assets
 - I used hassekf's grass background which is free to use in any game!
 https://opengameart.org/content/tower-defense-grass-background
 - I didn't know how to capture diagonal movement, so I googled it and came up with this solution!
 https://stackoverflow.com/questions/38804901/how-to-make-my-player-move-in-diagonal-lines-and-horizontal-lines
 
 */

// Variables ---------------------------------------------------//

// player variables
float playerX = 640;
float playerY = 620;
float playerWidth = 45;
float playerHeight = 50;
float playerHealth = 100;
float playerSpd = 5; //default 5
int currSprite; // decides the next sprite to display
PImage[] playerSprite = new PImage[2];

// enemy variables
Bunny[] bunnies;
float enemyWidth = 50;
float enemyHeight = 70;
int enemyNum = 3; //defualt 3
int enemyHit = 0;
float enemySpd = 1; //default 1

// ball variables
float ballWidth = 50;
float ballHeight = 50;
float ballSpd = 10; //default 10
String ballDir;
int ballStock = 5;
boolean spacePressed = false;
PImage ballStockSprite;
ArrayList<Ball> playerBalls = new ArrayList<Ball>();
//ArrayList<Ball> enemyBalls = new ArrayList<Ball>();

// game variables
PImage background;
int score = 0;
PFont font;
int collisionBuffer = 25;

// movement control variables
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

// Setup and Draw functions ------------------------------------//

void setup() {

  // Set game resolution
  size(1280, 720);

  // Set background, player sprites, and ball sprite
  background = loadImage("C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sprites/grass.jpg");
  playerSprite[0] = loadImage("C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sprites/chick0.png");
  playerSprite[1] = loadImage("C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sprites/chick1.png");
  ballStockSprite = loadImage("C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sprites/ball0.png");

  // Set font for scoreboard
  font = createFont("YU Gothic UI Bold", 32);
  
  // Set player health back to 100
  playerHealth = 100;

  // Load enemies at the start of the round
  loadBunnies();
}

void draw() {

  // Continue the game if the player health isn't 0
  if (playerHealth != 0) {

    // if all the enemies are hit, go to the next stage
    if (enemyHit == enemyNum) {
      nextStage();
    }

    // Clear screen
    image(background, 0, 0);

    // display score on the top left of the screen
    displayScore("topLeft");

    // display number of balls on top left of screen under score
    displayBallStock();

    // update & draw player
    updatePlayer();

    // throw ball if spacebar is pressed (initializes ball)
    if (spacePressed & ballStock > 0) {
      throwBall();
    } else {
      spacePressed = false;
    }

    // update ball positions (when airborn)
    updateBalls();

    // check for collisions between player, ball, and enemies
    checkCollision();

    // update each bunny location
    updateBunnies();

    // If player health is 0, then we end the game
  } else {
    endGame();
  }
}

// Checking Collisions -----------------------------------------//

void checkCollision() {

  // Check for collision between player-bunnies and balls-bunnies
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
      playerHealth = 0;
    }
    for (Ball ball : playerBalls) {
      boolean topLeftBallHit = ball.ballX + ball.ballWidth > b.bunnyX && ball.ballY + ball.ballHeight > b.bunnyY;
      boolean topRightBallHit = ball.ballX < b.bunnyX + b.bunnyWidth && ball.ballY + ball.ballHeight > b.bunnyY;
      boolean bottomLeftBallHit = ball.ballX + ball.ballWidth > b.bunnyX && ball.ballY < b.bunnyY + b.bunnyHeight;
      boolean bottomRightBallHit = ball.ballX < b.bunnyX + b.bunnyWidth && ball.ballY < b.bunnyY + b.bunnyHeight;

      // if all of these conditions are true, this bunny 'b' is hit by a ball
      if (topLeftBallHit && topRightBallHit && bottomLeftBallHit && bottomRightBallHit) {
        b.hit = true;
        enemyHit++;
        score++;
      }
    }
  }
}

// Updating Player, Balls, and Enemies  ------------------------//

// Loads bunny enemies
void loadBunnies() {
  bunnies = new Bunny[enemyNum];

  for (int i = 0; i < enemyNum; i++) {
    float bunnyX = pickEnemyX();
    float bunnyY = pickEnemyY(bunnyX);
    bunnies[i] = new Bunny(bunnyX, bunnyY, enemyWidth, enemyHeight, enemySpd);
  }
}

// updates the position of the bunnies
void updateBunnies() {
  for (Bunny bunny : bunnies) {
    if (!bunny.hit) {
      bunny.drawBunny();
    } else {
      // moving them off the canvas so they aren't an invisible obstacle
      bunny.bunnyX = -99999999;
      bunny.bunnyY = -99999999;
    }
  }
}

// initializes and throw the ball in the direction you're running
void throwBall() {
  playerMoveDir();
  Ball ball = new Ball(playerX, playerY, ballWidth, ballHeight, ballSpd, ballDir);
  playerBalls.add(ball);
  spacePressed = false;
  ballStock--;
}

// updates the position of the balls and adds 1 ball to stock every 1.5 seconds (90 frames)
void updateBalls() {
  for (Ball ball : playerBalls) {
    ball.drawBall();
  }
  if (frameCount % 90 == 0 && ballStock != 5) {
    ballStock++;
  }
}

// diosplays the number of balls that you have available to throw
void displayBallStock() {
  int firstBallX = 8;
  for (int i = 0; i < ballStock; i++) {
    image(ballStockSprite, firstBallX, 45, 25, 25);
    firstBallX += 40;
  }
}

// updates the position of the player
void updatePlayer() {
  updatePlayerPosition();
  image(playerSprite[currSprite], playerX, playerY, playerWidth, playerHeight);
  nextSprite();
}

// Helper Functions for enemy & player functions ---------------//

// Update player to next sprite
void nextSprite() {
  if (frameCount % 20 == 0) {
    currSprite++;
    if (currSprite > 1) {
      currSprite = 0;
    }
  }
}

// pick an X-coordinate to start the enemy from
float pickEnemyX() {
  return random(0, width-enemyWidth);
}

// pick a Y-coordinate to start the enemy from
float pickEnemyY(float xCord) {
  // If enemy ends up in center screen, spawn away from player
  if (width/5 <= xCord && xCord <= width - (width/5)) {
    return random(0, playerY/2);
  } else {
    return random(0, height-enemyHeight);
  }
}

// Display score at requested position
void displayScore(String location) {

  fill(0, 0, 0);
  if (location == "topLeft") {
    textFont(font, 32);
    text("Score: " + str(score), 8, 33);
    fill(240, 179, 46);
    text("Score: " + str(score), 7, 32);
  } else if (location == "center") {
    textFont(font, 50);
    textAlign(CENTER);
    text("Final Score: " + str(score), width/2, height/2);
    fill(240, 179, 46);
    text("Final Score: " + str(score), width/2 - 1, height/2 - 1);
    fill(0, 0, 0);
    text("Thank you for playing! :)", width/2, height/2 + 60);
    fill(240, 179, 46);
    text("Thank you for playing! :)", width/2 - 1, height/2 - 1 + 60);
  }
}

// starts the next stage
void nextStage() {
  enemyHit = 0;
  enemyNum++;
  enemySpd += 0.5;
  if (enemyNum % 5 == 0) {
    playerSpd++;
  }
  // Set player health back to 100
  playerHealth = 100;
  // Load enemies for start of next round
  loadBunnies();
}

// ends the game
void endGame() {
  image(background, 0, 0);
  image(playerSprite[currSprite], playerX, playerY, playerWidth, playerHeight);
  nextSprite();
  displayScore("center");
}

// Keyboard input (Control Scheme)------------------------------//

// captures key presses
void keyPressed() {
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
}

// captures key releases
void keyReleased() {
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
void updatePlayerPosition() {
  if (upPressed & playerY != 0) 
    playerY -= playerSpd;
  if (downPressed & playerY != height - playerHeight)
    playerY += playerSpd;
  if (leftPressed & playerX != 0)
    playerX -= playerSpd;
  if (rightPressed & playerX != width - playerWidth)
    playerX += playerSpd;
}

// updates player movement direction to determine ball direction
void playerMoveDir() {
  if (upPressed & leftPressed & !rightPressed & !downPressed)
    ballDir = "topLeft";
  if (upPressed & rightPressed & !downPressed & !leftPressed)
    ballDir = "topRight";
  if (downPressed & leftPressed & !upPressed & !rightPressed)
    ballDir = "bottomLeft";
  if (downPressed & rightPressed & !upPressed & !leftPressed)
    ballDir = "bottomRight";
  if (upPressed & !leftPressed & !rightPressed & !downPressed)
    ballDir = "top";
  if (downPressed & !upPressed & !leftPressed & !rightPressed)
    ballDir = "bottom";
  if (leftPressed & !upPressed & !rightPressed & !downPressed)
    ballDir = "left";
  if (rightPressed & !leftPressed & !upPressed & !downPressed)
    ballDir = "right";
}

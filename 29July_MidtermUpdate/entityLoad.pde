/*
Methods to load entities into the game during setup or during stage changes.
 */


// Load game files during setup so we don't have to load again
void loadGameFiles() {

  // PLEASE UPDATE THESE FILE PATHS IF YOU WANT TO PLAY BUNNY BALL ON YOUR OWN COMPUTER
  background = loadImage("C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sprites/grass.jpg");
  titleImg = loadImage("C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Menu/title.png");
  playButton = loadImage("C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Menu/b_3.png");
  playerSprite[0] = loadImage("C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sprites/chick0.png");
  playerSprite[1] = loadImage("C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sprites/chick1.png");
  ballStockSprite = loadImage("C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sprites/playerBall0.png");
  gameMusic = new SoundFile(this, "C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sounds/bgm.mp3");
  menuMusic = new SoundFile(this, "C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sounds/menu.mp3");
  playerHitSound = new SoundFile(this, "C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sounds/playerHit.mp3");
  enemyHitSound = new SoundFile(this, "C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sounds/enemyHit.mp3");
  ballThrowSound = new SoundFile(this, "C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sounds/ballToss.mp3");
  ballReloadSound = new SoundFile(this, "C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sounds/ballReload.mp3");
  font = createFont("YU Gothic UI Bold", 32);

  // load ball and bunny sprites
  for (int i = 0; i <= 3; i++) {
    playerBallSprite[i] = loadImage("C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sprites/playerBall" + str(i) + ".png");
    enemyBallSprite[i] = loadImage("C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sprites/enemyBall" + str(i) + ".png");
    bunnySprite[i] = loadImage("C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sprites/bunny" + str(i) + ".png");
    throwerBunnySprite[i] = loadImage("C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sprites/throwerBunny" + str(i) + ".png");
    playerHealthSprite[i] = loadImage("C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sprites/health_" + str(i) + ".png");
  }

  // load enemy health sprites
  for (int i = 0; i < 2; i++) {
    enemyHealthSprite[i] =  loadImage("C:/Users/ChaoN/Desktop/des inv 23/Bunny_Ball/Sprites/enemyHealth" + str(i) + ".png");
  }
}

// Loads bunny enemies
void loadBunnies() {
  bunnies = new Bunny[enemyNum];
  int numThrowers = 0;
  if (enemyNum > 5) {
    numThrowers = int(random(1, enemyNum - 5));
  }

  // load regular bunnies
  for (int i = 0; i < enemyNum - numThrowers; i++) {
    float bunnyX = pickEnemyX();
    float bunnyY = pickEnemyY(bunnyX);
    bunnies[i] = new Bunny(bunnyX, bunnyY, enemyWidth, enemyHeight, enemySpd, false);
  }

  // load thrower bunnies
  for (int i = enemyNum - numThrowers; i < enemyNum; i++) {
    float bunnyX = pickEnemyX();
    float bunnyY = pickEnemyY(bunnyX);
    bunnies[i] = new Bunny(bunnyX, bunnyY, enemyWidth, enemyHeight, enemySpd/3, true);
  }
}

// Loads ball throw in direction player is moving
void loadPlayerBall() {
  playerMoveDir();
  ballThrowSound.play(1, 0.5);
  Ball ball = new Ball(playerX, playerY, ballWidth, ballHeight, ballSpd, ballDir, "player", null);
  playerBalls.add(ball);
  spacePressed = false;
  ballStock--;
  ballRefreshTimer = 120;
}

// Load enemy ball to be thrown in direction of the player
void loadEnemyBall(float bunnyX, float bunnyY, Bunny b, float enemyBallSpd) {
  ballThrowSound.play(1.5, 0.5);
  Ball ball = new Ball(bunnyX, bunnyY, ballWidth, ballHeight, enemyBallSpd, ballDir, "throwerBunny", b);
  enemyBalls.add(ball);
}

// pick an X-coordinate to load the enemy from
float pickEnemyX() {
  return random(0, width-enemyWidth);
}

// pick a Y-coordinate to load the enemy from
float pickEnemyY(float xCord) {
  // If enemy ends up in center screen, spawn away from player
  if (width/5 <= xCord && xCord <= width - (width/5)) {
    return random(0, playerY/2);
  } else {
    return random(0, height-enemyHeight);
  }
}

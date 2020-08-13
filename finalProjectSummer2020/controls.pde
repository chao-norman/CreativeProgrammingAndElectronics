/*
Methods that handle player controls
 */


// captures mouse button press (if player hits menu buttons)
public void mousePressed() {

  if (mouseButton == LEFT) {

    // if player is on menu screen and presses play, advance gameState from 0 to 1
    if (gameState == 0) {
      if (mouseX > width/2 - 87.15/2 && mouseX < width/2 + 87.15/2 && 
        mouseY > (height/2 + 340) - 89.775/2 && mouseY < (height/2 + 340) + 89.775/2) {
        gameState = 1;
      }
    }
  }
}

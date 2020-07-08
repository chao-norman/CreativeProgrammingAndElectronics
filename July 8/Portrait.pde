/*
My inspiration for this drawing:
 - I wanted to draw me and my partner's first home together (we just moved in together recently!)
 - The backdrop I chose was our living room and couch, with us sitting together on the couch
 - I looked up a lot of the tools on the Processing reference site: https://processing.org/reference/
 - I also used google's RGB color picker to find my colors: 
 https://www.google.com/search?q=rgb+color+picker&rlz=1C1CHBF_enUS887US887&oq=rgb+color+picker&aqs=chrome.0.0l8.1836j0j7&sourceid=chrome&ie=UTF-8
*/


// Setting up canvas
void setup() {
  size(1250, 800);
  background(179, 158, 118);
}

// Drawing my portrait
void draw() {

  // Wall indentations
  for (int i = -127; i <= 1250; i += 200) {  
    fill(148, 130, 95);
    stroke(92, 84, 62);
    rect(i, 0, 5, 1000);
  }

  // Window
  fill(230, 251, 255);
  rect(960, 0, 1000, 250);

  // Window shelf
  fill(247, 241, 223);
  stroke(92, 84, 62);
  rect(950, 250, 1000, 15);
  quad(965, 250, 980, 230, 1250, 230, 1250, 250);

  // Window trim
  fill(105, 96, 72);
  rect(960, 0, 5, 250);
  fill(150, 133, 101);
  quad(965, 250, 980, 230, 980, 0, 965, 0);

  // window shades
  fill(240, 229, 201);
  for (int shadeHeight = 11; shadeHeight <=240; shadeHeight += 15) {
    quad(970, shadeHeight, 975, shadeHeight - 6, 1250, shadeHeight - 6, 1250, shadeHeight);
  }

  // Baseboard trim
  fill(105, 96, 72);
  rect(0, 490, 1250, 20);

  // Adding Carpet
  fill(247, 234, 195);
  rect(0, 500, 1250, 300);

  // Plant pot
  fill(245, 240, 237);
  ellipse(1080, 580, 120, 20);
  quad(1005, 450, 1155, 450, 1140, 580, 1020, 580);
  ellipse(1080, 450, 150, 20);
  fill(128, 123, 101);
  ellipse(1080, 450, 135, 10);
  fill(245, 240, 237);
  noStroke();
  ellipse(1081, 579, 119, 19);
  //quad(1010, 450, 1090, 450, 1070, 550, 1060, 500);

  // Plant
  fill(141, 212, 127);
  stroke(210, 219, 136);
  ellipse(1080, 400, 20, 110);
  ellipse(1080 + 50, 400, 20, 110);
  ellipse(1080 - 30, 400, 25, 110);
  ellipse(1080 + 10, 400, 20, 110);
  ellipse(1080 + 30, 400, 25, 110);
  ellipse(1080 - 10, 400, 20, 110);
  ellipse(1080 - 50, 400, 25, 110);

  // Couch legs (left then right)
  stroke(171, 137, 58);
  fill(133, 106, 45);
  quad(100, 650, 120, 650, 120, 680, 100, 680);
  fill(133, 106, 45);
  quad(820, 650, 840, 650, 840, 680, 820, 680);

  // Couch frame (upper)
  fill(186, 158, 91);
  stroke(97, 83, 50);
  quad(100, 319, 835, 319, 849, 329, 91, 329);
  fill(235, 201, 124);
  rect(90, 330, 760, 200);

  // Couch frame (lower);
  stroke(97, 83, 50);
  fill(222, 189, 113);
  quad(90, 530, 850, 530, 851, 630, 89, 630);
  fill(204, 174, 106);
  quad(89, 630, 851, 630, 850, 655, 90, 655);

  // Couch cushion
  fill(233, 240, 238);
  stroke(189, 199, 196);
  rect(100, 340, 740, 180, 45, 45, 0, 0);
  fill(189, 199, 196);
  rect(100, 560, 740, 60, 0, 0, 45, 45);
  fill(233, 240, 238);
  rect(100, 520, 740, 80, 0, 0, 45, 45);

  // Drawing Norman (me!)
  
  // neck
  fill(240, 219, 173);
  rect(565, 350, 20, 25);
  // head
  fill(247, 232, 200);
  ellipse(575, 300, 110, 140);
  // shoulder and body
  fill(177, 186, 185);
  noStroke();
  quad(530, 375, 620, 375, 635, 410, 515, 410);
  quad(515, 410, 635, 410, 645, 550, 505, 550);
  // legs
  fill(192, 169, 214);
  quad(510, 550, 575, 550, 570, 750, 510, 750);
  quad(575, 550, 635, 550, 640, 750, 580, 750);
  // feet (left then right)
  fill(232, 216, 183);
  ellipse(540, 750, 50, 20);
  ellipse(610, 750, 50, 20);
  // arms (right then left)
  fill(138, 150, 149);
  quad(620, 375, 640, 410, 625, 600, 600, 600);
  quad(510, 410, 530, 375, 545, 600, 520, 600);
  // hands (right then left)
  fill(232, 216, 183);
  ellipse(532, 600, 25, 20);
  ellipse(612, 600, 25, 20);
  // eyes (right then left)
  fill(0, 0, 0);
  ellipse(600, 295, 30, 15);
  fill(247, 232, 200);
  ellipse(600, 300, 30, 15);
  fill(0, 0, 0);
  ellipse(550, 295, 30, 15);
  fill(247, 232, 200);
  ellipse(550, 300, 30, 15);
  // mouth
  fill(0, 0, 0);
  ellipse(575, 330, 30, 15);
  fill(247, 232, 200);
  ellipse(575, 325, 30, 15);
  // hair
  fill(0, 0, 0);
  quad(519, 320, 520, 270, 560, 215, 550, 260);
  quad(632, 320, 629, 270, 610, 215, 600, 260);
  quad(558, 215, 612, 215, 600, 260, 550, 260);



  // Drawing Lily (person on the left -- my partner whom I'm living with)
  
  // hair (in background)
  fill(0, 0, 0);
  quad(330, 325, 420, 325, 430, 420, 320, 420);
  // neck
  fill(240, 219, 173);
  rect(365, 375, 20, 25);
  // head
  fill(250, 232, 192);
  ellipse(375, 325, 100, 130);
  // shoulder and body
  fill(192, 240, 205);
  noStroke();
  quad(315, 425, 330, 400, 420, 400, 435, 425);
  quad(315, 425, 435, 425, 440, 550, 310, 550);
  // legs
  fill(135, 212, 193);
  quad(310, 550, 375, 550, 368, 740, 310, 740);
  quad(375, 550, 440, 550, 435, 740, 378, 740);
  // feet (left then right)
  fill(232, 216, 183);
  ellipse(340, 740, 45, 20);
  ellipse(405, 740, 45, 20);
  // arms (left then right)
  fill(171, 219, 184);
  quad(310, 425, 330, 400, 345, 590, 320, 590);
  quad(420, 400, 440, 425, 430, 590, 405, 590);
  // hands (right then left)
  fill(232, 216, 183);
  ellipse(333, 590, 23, 18);
  ellipse(418, 590, 23, 18);
  // eyes (right then left)
  fill(0, 0, 0);
  ellipse(400, 325, 30, 15);
  fill(247, 232, 200);
  ellipse(400, 330, 30, 15);
  fill(0, 0, 0);
  ellipse(350, 325, 30, 15);
  fill(247, 232, 200);
  ellipse(350, 330, 30, 15);
  // mouth
  fill(0, 0, 0);
  ellipse(375, 350, 30, 15);
  fill(247, 232, 200);
  ellipse(375, 345, 30, 15);
  // hair (top)
  fill(0, 0, 0);
  quad(400, 250, 320, 360, 330, 280, 350, 260);
  quad(375, 260, 430, 360, 425, 280, 430, 275);
  
  // Adding a cushion on the couch
  fill(196, 127, 94);
  rect(150, 450, 100, 100, 15, 15, 15, 15);
  fill(232, 150, 111);
  rect(155, 455, 90, 90, 15, 15, 15, 15);
  
}

## Midterm Update Assignment using Arduino Input

#### Description of Project:

* My update displays an LED "stoplight" output on the arduino and when the light hits green, it means that you have a powerup available in my midterm game "Bunny Ball". This powerup increases your player speed, your ball speed, the number of balls you have, and how quickly you reload. It also lowers the speed of all enemies in the proceeding rounds, as long as you clear the current stage in time! I call this power up "Matrix Mode". 

#### Anything clever or tricky:

* I found that reading input from my arduino was really tricky, especially when trying to include arduino input on a project that was already expansive and working beforehand. A lot of the changes that I implemented in order to try and get the arduiuno input to work made other facets of my program stop working, which made it really difficult to debug.

#### Problems (if any) and how you overcame them:

* I'm having a problem where the arduino input and output is working correctly and the game states are changing correctly to account for the "power up" mode from the arduino button push, but I'm not able to use my directional keys to move my character anymore. It seems like the game is still detecting the directional keys being pressed because I can shoot the ball in different directions, but my character remains stationary now and I'm not sure why. 

#### Schematic:

![](Schematic.jpg)


#### Photograph of arduino:


![](arduino_image.jpg)


#### Closeup of electronics:


![](close_up_of_electronics.jpg)

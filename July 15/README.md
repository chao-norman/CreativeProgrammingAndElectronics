## Making a game!

#### Describe your inspiration, and include links:

* My inspiration for this game was the bullet-hell iOS/Android game [Archero](https://play.google.com/store/apps/details?id=com.habby.archero&hl=en_US). I've been playing this game quite a lot recently because it's celebrating its 1 year anniversary. I thought that it might be fun to try and make my own bullet-hell type game using Processing! I decided to make a dodgeball type game, where you play as a little chick that is playing dodgeball versus a bunch of bunnies. Although I didn't fully get the enemies to also throw balls themselves just yet, you do have to worry about touching the bunnies since that will automatically end the game! I'll most likely update the game again in the future to add this feature.

#### Describe the rules you used to create this project and briefly how you programmed this to happen:

* One rule that's important in this game is the dodgeball mechanic. If you throw a ball (using the spacebar) and it hits a bunny, the bunny will disappear and your score will go up. This is the only way to currently score points, so its really important! I used ArrayLists and lists to keep track of ball instances and bunny instances and used nested for loops to go through each of the lists and check to see if any ball is touching any bunny. If a ball is touching a bunny, then I decactivate that particular bunny instance by changing its x-coordinate and y-coordinate outside of the canvas and setting its speed to 0 so that you can't be damaged by it. 

* Another rule that is important in Bunny Ball is that you only have 5 balls at a time. These balls recharge once every 1.5 seconds, so you need to make sure you use your dodgeballs wisely! I programmed this by using a global variable to keep track of the number of balls at a time, decrementing it whenever you throw a ball, and incrementing it every 1.5 seconds (or 90 frames when playing on 60fps) up to a limit of 5! I took advantage of the frameCount system variable to increment the ball count.

* All the bunnies are randomly generated at a random (x, y) coordinate that is away from the player, so the player should never instantly lose at the start of the round. I initialize all the bunnies at the end of every setup() phase at the start of each round by running a for loop to create new Bunny instances (using the random() function to generate random coordinates) and storing them in a list. I then access this list whenever I need to update or check the positions of the bunnies in the future using for loops.

#### Describe any difficulties you had and how you overcame them:

* One of the big difficulties that I had in this project was programming the dodgeballs. It was a lot more difficult than I expected to keep track of all the balls, the directions they're initially moving in, and checking to see whether they hit a bunny or not. I spent a lot of time debugging this in order to get the functionality correct and had to make a new function and a new global variable to keep track of this initial ball direction.

* Another difficulty that I had was trying to make the game end when you touched a bunny. It was really difficult to program all the conditions for the game to end, since I had to check whether you are touching a bunny from every single direction. I overcame this issue by drawing a diagram in my notebook and figuring out which variables from the player I needed to add, subtract, and then compare with the variables of each bunny in order to get this feature to work.

#### Mention anything interesting you discovered while doing this assignment:

* When doing this assignment, I realized that I didn't need to limit myself in terms of using for loops or nested for loops in order to check multiple lists at once. When doing practical projects in computer science, you always have to worry about run time, memory, and efficiency. In this case, because we were just making a simple game without having to keep track of many moving parts all at once, I could freely use any algorithm I wanted even if it wasn't the most efficient, and my game ran just fine!

* Another thing that I discovered while doing this assignment was that abstraction when designing games is INCREDIBLY powerful. I often found myself reusing lines of code and then abstracting them away to functions or additional classes in order to make my code a lot simpler and more legible for me. I also organized my code in categories, which helped my see where all my functions were due to the length of this project.

#### Credits:

* I used [Pixel Pete's Art Assets]( https://petermilko.itch.io/pixel-petes-art-assets)  which are free to use in any game; thank you Pete!

* I also used [hassekf's grass background]( https://opengameart.org/content/tower-defense-grass-background) as the background for my game, which they gave people permission to use in their tower defense games; thanks hassekf!

* I didn't know how to capture diagonal movement, so I googled it and followed this [solution]( https://stackoverflow.com/questions/38804901/how-to-make-my-player-move-in-diagonal-lines-and-horizontal-lines) on stackoverflow in order to make my own movement control implementation work correctly.


##### Below is a short gif of my project. If you want to play the game locally on your own computer, feel free to copy the code! Just make sure you set the correct paths for the sprites in the code. If you're any having trouble, feel free to message me! 

![](bunny_ball.gif)


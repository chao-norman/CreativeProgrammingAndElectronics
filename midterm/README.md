## Improving my previous game: Bunny Ball!

For my midterm assignment, I wanted to improve on the game that I made for the July 15 assignment. I had a lot of fun working on it last week, but I didn't get very far in all the functionality that I wanted to include. I polished my game up quite a bit in this update and I hope to improve upon it even more in the future! 

#### How I improved my game:

* [new] Added a title screen menu with music, instructions, a game logo, and a functional play button to start the game.

* [new] Added pause functionality so the player can pause the game whenever they want.

* [new] Added a play again feature for when you lose the game (without having to quit the game and restart it).

* [new] Added a health bar and changed layout for in-game player information.

* [new] Added background music that plays during the game and when the player has lost (is on the play again screen). Also added soundbytes that play for interactions during the game (eg. player takes damage, enemy takes damage, player throws ball).

* [new] Added an additional enemy that shoots projectiles at the player.

* [new] Added a high score counter so the player can continuously try to beat their high score.

* [update] Updated enemy spawning algorithm to include some randomness (makes each run a little bit more unique).

* [update] Organized program functions into different .pde files depending on their functionality. (eg. Methods that loaded entities are in the entityLoad.pde file. Methods that update entities are in the entityUpdate.pde file.)

* [fix] Fixed a bug from the previous update where the player could clip OUTSIDE the canvas, making them essentially invincible since the enemies couldn't go off the canvas to damage the player.

* [fix] Fixed a bug where the player information in-game (score, health, and number of balls) was rendered behind the enemies instead of in front of them.

#### Difficulties and Challenges:

* One of the biggest difficulties that I had during this assignment was the algorithm for the new enemy throwing a ball at the player. I frequently faced issues where the enemy threw the ball insanely fast, making it impossible for the player to react and dodge the ball in time. On the opposite end, I also faced issues where the enemy threw the ball incredibly slow, which made it a long-term on-screen obstacle for the player until they cleared the round. I ended up solving this issue by doing integer checks for both the xSpd and the ySpd of the ball after it's thrown by the enemy to make sure that it's within a speed range that I'm comfortable with. I'll most likely go back to this problem when I have some more time and figure out a more elegant solution.

#### Future plans:

* I want to add more enemy types. I'll have to get a bit more creative though since all my enemies are supposed to be bunnies!

* I also want to add power ups for the player as they progress through the game. The game can get very ruthless since there's no limit to enemies at the moment (since there are only 2 enemy types). Adding power ups seems like a good way to make the game more interesting and also adds to the uniqueness of each playthrough.

* VERY VERY rarely an enemy may spawn on top of the player and the player will take damage. I'll need to go figure out a better algorithm for spawning the enemies so that they can spawn in every open space on the canvas but NOT nearby a player. 

#### Credits:

* Please take a look at the file "timeline_credits_todos.txt"  for a complete list of credits! I listed every source that I used to make this project in there, along with the relevant links. I don't take credit for the creation of any of these free-to-use assets and I'm incredibly grateful to the people who made these assets available for use for anyone! 

##### Below is a short video of my project at this point in time. If you want to play the game locally on your own computer, feel free to download the files! Just make sure you set the correct paths for the sprites and sounds in entityLoad.pde. Feel free to reach out to me if you're running into trouble!

![](bunny_ball_video.mp4)


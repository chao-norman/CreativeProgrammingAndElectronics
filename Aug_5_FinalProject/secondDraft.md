# Final Project Proposal (revised)

##### Description of project in detail:

- For my final project, I want to create a game in Processing that's completely controlled by arduino input. 
- The game itself would be inspired by the original [Starfox games](https://www.youtube.com/watch?v=FU-a6ZkF0io), and I want the player to be controlling a fighter pilot and shooting down enemies. The aesthetic of the game would ideally follow a [vaporwave/outrun style](https://www.google.com/search?q=vaporwave&rlz=1C1CHBF_enUS887US887&sxsrf=ALeKk02ZbFwJWEJcCjXOr_shlquuOFA9Ag:1596606077303&source=lnms&tbm=isch&sa=X&ved=2ahUKEwiyt9WQrYPrAhVEsZ4KHe00AQsQ_AUoAXoECBoQAw&biw=767&bih=720) if I can figure out how to get that working in Processing. I want the player to have full control over whether the plane is going left, right, up, down, speeding up, slowing down, shooting lasers, and doing barrel rolls. 

##### What components will I use (or plan to use)?

- **Buttons:** shoot lasers and do barrel rolls (air maneuvering to dodge enemy attacks)
- **Rotary Encoder Modules**: control whether the plane is going left or right and up or down
- **Ultrasonic Distance Sensors:** control the speed of the aircraft (to be controlled like pedals)
- **OLED Display Board:** display animation of allies who are talking to you
- **LCD:** display text when allies are talking to you
- **Piezo Buzzer:** play sounds when shooting lasers and when doing a barrel roll

##### What is the riskiest part of my project?

- The riskiest part of my project would probably be the scale of this project. I'm already anticipating a LOT of problems in getting all the parts working and getting the communication between arduino and processing working properly. I'm not even sure if I'll be able to use all of these components at once and have Processing read all of these inputs quickly (and separately) just from serial communication. There might be a slight or moderate delay because of that and I don't want this project to have any delay at all. After getting the inputs working correctly, coding the player movement, environment, enemies, and other game mechanics will be difficult as well. I'm also concerned whether I'll be able to finish this project in time. 

##### What do I plan to do to mitigate this risk?

- I'm planning to spend a lot of time reading up documentation and trying each of these components individually first before I use them in unison. If I can get each of these components working individually, then I think that I'll have a chance to finish this project in time and in decent condition. I also plan to try and get all the components working together and the communication between the input modules, arduino, and processing as quickly as possible so that I have an indicator whether or not it's possible. If it's not possible, then I'll have to reconsider my project options or change the scale of the project.



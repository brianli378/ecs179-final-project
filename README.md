# Simulacrum #

## Summary ##

**A paragraph-length pitch for your game.**

## Project Resources

[Web-playable version of your game.](https://rythamdawar.itch.io/simulacrum)  
[Proposal: make your own copy of the linked doc.](https://docs.google.com/document/d/1SkqecsexLy4xXZBQBKxyo_UqOyL4xPAojTE3pR8BuLM/edit?tab=t.0)  

## Gameplay Explanation ##

**In this section, explain how the game should be played. Treat this as a manual within a game. Explaining the button mappings and the most optimal gameplay strategy is encouraged.**


**Add it here if you did work that should be factored into your grade but does not fit easily into the proscribed roles! Please include links to resources and descriptions of game-related material that does not fit into roles here.**

# External Code, Ideas, and Structure #

If your project contains code that: 1) your team did not write, and 2) does not fit cleanly into a role, please document it in this section. Please include the author of the code, where to find the code, and note which scripts, folders, or other files that comprise the external contribution. Additionally, include the license for the external code that permits you to use it. You do not need to include the license for code provided by the instruction team.

If you used tutorials or other intellectual guidance to create aspects of your project, include reference to that information as well.

# Team Member Contributions #

This section be repeated once for each team member. Each team member should provide their name and GitHub user information.
For each team member, you shoudl work of your role and sub-role in terms of the content of the course. Please look at the role sections below for specific instructions for each role.

Below is a template for you to highlight items of your work. These provide the evidence needed for your work to be evaluated. Try to have at least four such descriptions. They will be assessed on the quality of the underlying system and how they are linked to course content.

Short Description - Long description of your work item that includes how it is relevant to topics discussed in class. link to evidence in your repository

Here is an example:
Procedural Terrain - The game's background consists of procedurally generated terrain produced with Perlin noise. The game can modify this terrain at run-time via a call to its script methods. The intent is to allow the player to modify the terrain. This system is based on the component design pattern and the procedural content generation portions of the course. The PCG terrain generation script.

You should replay any bold text with your relevant information. Liberally use the template when necessary and appropriate.

Add addition contributions in the Other Contributions section.


# Alyssa Goldgeisser - [github](https://github.com/killmanjaro) #
## Animation and Visuals

**Character Design**  
Using Aseprite, I created animations for our player character. The character design went through many iterations until it was something I was happy with. 
I wanted to design a character that would be visually distinct, with their own symbol/color so they could be recognizable. Her symbol is the red spade,
which kinda looks like an ubside down heart due to the small amount of pixels. This character and her colors are supposed to look unique around the background
of the simulation, showing the distinction between her and the rest of the world. 

**First Character Design**  
<img width="1153" height="554" alt="image" src="https://github.com/user-attachments/assets/3182e5ea-b740-4801-ba3e-a97f14792074" />
This was okay, but it was a little too detailed to fit in with the rest of the game. I realized when working with guns they would need
to fit the same level of detail which wasnt attainable. Also, the character looks a little unfit for a shooter game, where this type
of sprite seems more fit for a story game.


**Final Character Design**
<img width="1957" height="757" alt="image" src="https://github.com/user-attachments/assets/2e7b2c33-a38a-48fd-8c85-4a56f1c352e1" />
Final character design is more in line with the scope of the game, and fits more with the style of the game (action rather than story).


**Sprites for all guns**
<img width="976" height="557" alt="image" src="https://github.com/user-attachments/assets/628ac3b9-312e-4a71-8e25-52a5525b097f" />
25 unqiue sprites for each gun, including 5 base guns and 20 fusions. Each fusion sprite takes elements from its parents, and is supposed
to communicate its properties. The laser weapons are techy and blue, the rocket weapons are bright yellow/orange to show their explosive
and dangerous nature, and the pistol is supposed to fit the player characters style (since it is her weapon at the start of the game).


**Sprites for maps**  
<img width="595" height="151" alt="image" src="https://github.com/user-attachments/assets/241b4fd4-8c70-4012-a47f-33d322922b55" />  
Designed the map tile set, working through multiple iterations to fit the cyberpunk theme and simulation asthetic. Painted the tile set for each map.  


**Title screen**
<img width="1269" height="710" alt="image" src="https://github.com/user-attachments/assets/95a41769-a931-40c9-921d-0651d44dfd49" />
Used an open source assets to create a parralax side scrolling meny screen, also designed the game name.


**Crafting screen**
<img width="1047" height="526" alt="image" src="https://github.com/user-attachments/assets/0deb0529-aa26-450c-b979-ddae4c164972" />
Added upon an inventory system by creating slots for the fusion, and allowing the player to see the result of the fusion. 
Also adjusted the visuals for the fusion inventory to more match the cyberpunk theme.  

**Enemy animations**
<img width="954" height="435" alt="image" src="https://github.com/user-attachments/assets/0e3a5309-e141-4b6d-9006-ec71408c9ccd" />
Created enemy sprites and animations, fiting the cyberpunk and simulation theme. Enemies are designed to be part of the simulation,
being just basic enemies that may be also trapped in the simulation.

**Health Bar**  
<img width="366" height="61" alt="image" src="https://github.com/user-attachments/assets/3c3899c2-a69b-4397-9a68-1fd7c2166b9d" />  
Created Animation for health bar changing, and designed health bar to fit with the game style.

**Crosshair and reload animation**
<img width="2023" height="90" alt="crosshair_reload" src="https://github.com/user-attachments/assets/2d05a8ee-817f-482e-9aa4-e047c595bd84" />
Created dynamic crosshair reload animation so that the time for the animation lines up with the guns reload time.


## Game Feel  


**Gun Aiming**  
(Gun manager document)[https://github.com/brianli378/ecs179-final-project/blob/b230fc00ffed08b438a4a62bb368e78be7c1cfce/2d-roguelike/scripts/gun_manager.gd#L100-L135]
Depending on where the player is looking, the model switches which direction it looks and the gun rotates with the mouse cursor to look exactly
where the player is looking. This allows for smooth gameplay, where the player can focus aiming individually from movement. 


**Gun Rotation, Position Offset, and Projectile Spawn Offsets**  
(gun_data.gd)[https://github.com/brianli378/ecs179-final-project/blob/bd280ceb1ddd8d4181a454adb475c3dd9e8ed069/2d-roguelike/scripts/gun_data.gd#L1-L242]
Manually changed the offsets and position of each gun to have the rotation to look natural even on the change of the size of the gun.
All of this information was manually edited.


**Adjusting Map Collision**  
<img width="256" height="98" alt="image" src="https://github.com/user-attachments/assets/a0ec1fa9-2add-487d-859e-459425d6d0d1" />  
Manually adjusting map collisions so enemies and players wouldnt get stuck on map objects, and make the movement more fluid.

## Other Contrubutions

**Designed All of the fusion guns**
(Fusion gun design document)[https://docs.google.com/document/d/1bNHDFz7tdk0n9OXliNgc_nxGdNC5oqgv6N0_m0_iOEU/edit?tab=t.0]  
Designed every gun fusion, including stats, inspiration images, and other game examples.

# Brian Li [github](https://github.com/brianli378) #
## Game Logic
I developed and implemenyed the majority of the game logic, including the player movement, player aim, player dash, 2D lerp camera, camera shake, reload logic, inventory logic and fusion logic.

## Gameplay Teating
I performed extensive testing and also helped fix bugs that ended up surfacing, including bugs where the player sprite glitched from the lerp camera leash, needing to wait shot_delay when switching to a new weapon, needing to wait shot_delay after the player's final bullet before reloading, the player hurt sound repeating infinitely when hit by a rocket and the boss dropping too many guns due to the death logic being called multiples times.



# Team Member #3 #
## Main Role

**Documentation for main role.**

## Sub Role

**Documentation for Sub-Role**

## Other Contrubutions

**Documentation for contributions to the project outside of the main and sub roles.** 

# Team Member #4 #
## Main Role

**Documentation for main role.**

## Sub Role

**Documentation for Sub-Role**

## Other Contrubutions

**Documentation for contributions to the project outside of the main and sub roles.** 

# Team Member #5 #
## Main Role

**Documentation for main role.**

## Sub Role

**Documentation for Sub-Role**

## Other Contrubutions

**Documentation for contributions to the project outside of the main and sub roles.** 

# Team Member #6 #
## Main Role

**Documentation for main role.**

## Sub Role

**Documentation for Sub-Role**

## Other Contrubutions

**Documentation for contributions to the project outside of the main and sub roles.** 


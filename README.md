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
https://github.com/brianli378/ecs179-final-project/blob/b230fc00ffed08b438a4a62bb368e78be7c1cfce/2d-roguelike/scripts/gun_manager.gd#L100-L135
Depending on where the player is looking, the model switches which direction it looks and the gun rotates with the mouse cursor to look exactly
where the player is looking. This allows for smooth gameplay, where the player can focus aiming individually from movement. 


**Gun Rotation, Position Offset, and Projectile Spawn Offsets**  
https://github.com/brianli378/ecs179-final-project/blob/bd280ceb1ddd8d4181a454adb475c3dd9e8ed069/2d-roguelike/scripts/gun_data.gd#L1-L242
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
My main role was Game Logic. Throughout development, my main focuses on the project were the logic and implementation of the core gameplay systems, including player logic (movement, aim, dash), camera logic (2d lerp camera, camera shake), reload logic, inventory logic and fusion logic. 

**Player and Camera**

The player is implemented as a CharacterBody2D with movement and a dash mechanic. The player script reads and responds to the basic WASD user input and "looks at" the global mouse position. On top of basic movement, I also implemented a smooth dash mechanic. When the dash input is pressed, velocity is boosted in the direction the player is moving then decelerates back down to the normal movement velocity. The smooth acceleration and deceleration on the dash make the player movement feel more fluid, and combined with the 2D lerp camera provides a polished movement experience for the player.

I also implemented the camera behavior. Instead of the default 2D position lock camera, I drew inspiration from exercise 2 to implement a 2D version of the 3D lerp position lock camera from the assignment. I also added a camera screen shake function called by the gun manager any time a gun is fired. The add_shake function works by choosing a random offset for x and y between -1.0 and 1.0 and applying it to the camera. The function also takes in a float shake_multiplier as input, allowing adjustable shake intensity for different guns.

**Ammo and Reload**

When the guns were first added, there was no existing ammo system so all guns could be shot for as long as possible without the need to reload or worry about ammo. I implemented the ammo and reload system inside the gun manager and also added a gun spec file which kept track of the magazine size, starting reserve, max reserve and reload of each weapon. When the player shoots, ammo in the current magazine gets decremented. If the magazine is empty and the player tries to shoot, an auto reload system automatically begins a reload for the player. I also implemented a manual reload triggered by pressing “R” in case the player is low on ammo and wants to reload before getting into a fight. 

To support the reload system, I implemented a CanvasLayer into the game for the player’s HUD. The script would read the current gun key and pull the ammo in the player’s current guns magazine and reserve, displaying them in the standard mag/reserve format. A reloading label also appears whenever the player begins a reload, providing a heads up so the player knows they can’t shoot during that time.

**Inventory**

The player could cycle through the different guns they were holding, but there was still no way to display all the guns. We also needed somewhere to perform the fusion, so I was in charge of creating the player’s inventory. On button press, a CanvasLayer that contains the inventory appears with containers for each of the player’s weapons. This inventory_ui.gd script connects to the GunManager and reads its gun_keys to determine which weapons the player currently owns. The inventory then dynamically displays those guns for the player. This inventory system was also the base of which I built the fusion system on.

**Fusion**

To implement the fusion system, I built on the existing gun logic that Alex worked on. The GunManager had a collection of guns identified by string keys for both base weapons (ex: "pistol", "machine gun", "sniper", etc) and fusion weapons ("laser machine gun", "pachine gun", etc). I added the fusion recipes, a mapping from pairs of gun keys to a resulting gun key, and mapping from those fusion gun keys to the actual gun classes that Alex had created. In the inventory UI, I added a fuse button and selection logic. In my original implementation, the player would begin fusion by pressing the fuse button, then click on any two guns in the inventory and press the fuse button one more time to finalize the fusion, removing the consumed weapons (along with their ammo entries) and adding in the new fused weapon into the player inventory. It then initializes the new fusion gun's ammo.


## Gameplay Teating
My secondary role was Gameplay Testing. Along with constantly testing and iterating on my own implementations to make sure they were bug free, I also spent time handling bug fixes that popped up during development. A few notable examples are:

**Weapon swap and fire timing:**

After the weapon implementation, there was a bug where every time the player switched guns they had to wait _time_since_last_shot until they could shoot the gun they switched to. While this had minimal effect on guns like the machine gun that could shoot very quickly, it could clearly be felt when switching to a sniper or rocket launcher and having to wait a few seconds before being able to shoot the first bullet. I fixed this by resetting the timer on gun switch, making the gun swapping feel a lot more responsive.

**Reloading during fusion:**

After implementing the fusion system, I ran into a bug where if you reloaded a non-fused gun then fused it and switched to the newly fused gun, the game would completely crash. This was due to the reload logic from guns that no longer existed being accessed. I fixed this by adding safeguards to values accessed in the gun manager.

**Boss dropping duplicate guns:**

One of our core game mechanics is that the boss drops the player new base weapons which the player can then use to fuse new weapons. While playtesting one day, I ran into an issue where when I killed the boss with a machine gun I would receive way more than the regular 2 guns I was supposed to receive. This ended up being due to the enemy _handle_death function being called multiple times upon boss death. The fix to this was pretty simple, I just moved the _is_dying guard from the bottom of the function to the top so it would return instantly and no longer provide multiple duplicate guns.

**Player hurt sound played nonstop when hit by a rocket:**

This was another issue that emerged when playtesting. The player's hurt sound was being played repeatedly forever whenever the player got hit by an enemy rocket. The damage sound was played whenever health_bar.value > health and health_bar.update_health(health) was called after. Regular bullets use integer damage but the rocket used float damage and the health_bar was also integer based, so when the player got hit by a float damage rocket and the health dropped to a float number (for example, 7.7), the health bar value would still update to integer 8 so it would loop 8 > 7.7 and play the sound forever. I fixed this by rounding the player damage taken to an integer.



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


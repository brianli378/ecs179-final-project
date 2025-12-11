# Simulacrum #

## Summary ##

**In a cyberpunk dystopian world, you know very little of your current predicament, but what you do know is enough. One: this is not real, and two: whoever or whatever put you here is not above killing their captives. In this trapped simulation, your only option for survival lies in an odd nature of the guns you collect. Within this simulated world, these guns can be fused together into deadly combination, and these weapons are the key to your survival. Your limits will be tested, and you have a sneaking suspicion that your captors aren't afraid of that; In fact, they count on it.**

## Project Resources

[Web-playable version of your game.](https://rythamdawar.itch.io/simulacrum)  
[Proposal: make your own copy of the linked doc.](https://docs.google.com/document/d/1SkqecsexLy4xXZBQBKxyo_UqOyL4xPAojTE3pR8BuLM/edit?tab=t.0)  

## Gameplay Explanation ##

**In this section, explain how the game should be played. Treat this as a manual within a game. Explaining the button mappings and the most optimal gameplay strategy is encouraged.**
You spawn in a safe zone, given some time to try out the weapons before heading to the right to the main map.  

This game has the general WASD movement. You can also press shift to dash. P is the pause button. I or B is your inventory button. In your inventory, at the top is a list of weapons that you have. You start with all 5 weapons at the top, the pistol, the shotgun, the machine gun, the sniper and the rocket launcher. You are encouraged to try out a fusion in the inventory, look through the results of a couple of fusions. In the fusion menu, the first slot is generally the firing style and the second slot is generally the projectile type. This rule does get broken, the entire reference sheet is here: [Fusion gun design document](https://docs.google.com/document/d/1bNHDFz7tdk0n9OXliNgc_nxGdNC5oqgv6N0_m0_iOEU/edit?tab=t.0). The inventory only has 5 slots, and if you gain any items, the item in red will be deleted. So, generally we expect players to make a fusion or two every round so this doesnt happen.  
  
When you enter the main room, there are a couple of randomly generated enemies. Clear through them, and keep exploring the map, looking for enemies to kill. Once all the enemies on the map are killed, you will be transported to the Boss fight. The Boss has a randomly generated fusion gun, and is generally tougher than the basic enemies. You must clear the boss to proceed. One you kill the boss, he will drop you the components of the fusion in your inventory. You will be automatically transported into the safe room (careful not to move out of it on accident), where you will be able to try out the new fusions. You get a bit of health back, but the game is designed to be played in these rounds endlessly. Enemies get tougher every round, so it becomes harder and harder to clear. But, you also get to try out more fusions, and eventually find some fusion that helps you clear farther. 


**Add it here if you did work that should be factored into your grade but does not fit easily into the proscribed roles! Please include links to resources and descriptions of game-related material that does not fit into roles here.**

# External Code, Ideas, and Structure #

If your project contains code that: 1) your team did not write, and 2) does not fit cleanly into a role, please document it in this section. Please include the author of the code, where to find the code, and note which scripts, folders, or other files that comprise the external contribution. Additionally, include the license for the external code that permits you to use it. You do not need to include the license for code provided by the instruction team.

If you used tutorials or other intellectual guidance to create aspects of your project, include reference to that information as well.
  
[Side scrolling background of main menu](https://craftpix.net/freebies/free-scrolling-city-backgrounds-pixel-art/?num=1&count=1381&sq=scrolling%20city%20backgrounds%20pixel%20art%20gif&pos=3)  

[Tile map helper](https://arttale.itch.io/tilemap-templates) - Used these online tile map templates to ease the repetition of drawing many tiles (These tile sets and tutorial allow for what you draw to be automatically replicated on other tiles)

[Pixel Art Font](https://www.dafont.com/minecraft.font) - used open source minecraft font to give the game a consistent art style
  
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
Used Aseprite to create animations for the character, moving in both directions. 


**Sprites for all guns**
<img width="976" height="557" alt="image" src="https://github.com/user-attachments/assets/628ac3b9-312e-4a71-8e25-52a5525b097f" />
25 unqiue sprites for each gun, including 5 base guns and 20 fusions. Each fusion sprite takes elements from its parents, and is supposed
to communicate its properties. The laser weapons are techy and blue, the rocket weapons are bright yellow/orange to show their explosive
and dangerous nature, and the pistol is supposed to fit the player characters style (since it is her weapon at the start of the game).
Creating all these sprited took a lot of research, as a lot of them are inspired by real life guns or in game guns. I spent a lot of time
also creating the fusion guns to look unique, futuristic, and also a combination of its two base guns (enough to be semi recognizable).


**Sprites for maps**  
<img width="595" height="151" alt="image" src="https://github.com/user-attachments/assets/241b4fd4-8c70-4012-a47f-33d322922b55" />  
Designed the map tile set, working through multiple iterations to fit the cyberpunk theme and simulation asthetic. Painted the tile set for each map.  
As said before, I used [Tile map helper](https://arttale.itch.io/tilemap-templates) to ease some of the repetition in creating the tile
sets ( all final tiles are drawn by me, just used the tool). 


**Title screen**
<img width="1269" height="710" alt="image" src="https://github.com/user-attachments/assets/95a41769-a931-40c9-921d-0651d44dfd49" />
Used an open source assets [Side scrolling background of main menu](https://craftpix.net/freebies/free-scrolling-city-backgrounds-pixel-art/?num=1&count=1381&sq=scrolling%20city%20backgrounds%20pixel%20art%20gif&pos=3) to create a parralax side scrolling meny screen, also designed the game name.
Used inspiration from some online tech fonts to create the title of the game in asperite. 


**Crafting screen**
<img width="1047" height="526" alt="image" src="https://github.com/user-attachments/assets/0deb0529-aa26-450c-b979-ddae4c164972" />
Added upon an inventory system by creating slots for the fusion, and allowing the player to see the result of the fusion. 
Also adjusted the visuals for the fusion inventory to more match the cyberpunk theme. The inventory also displays what parts
of each gun the fusion will receive, and also what type of projectile/firing type the guns have. 


**Enemy animations**
<img width="954" height="435" alt="image" src="https://github.com/user-attachments/assets/0e3a5309-e141-4b6d-9006-ec71408c9ccd" />
Created enemy sprites and animations, fiting the cyberpunk and simulation theme. Enemies are designed to be part of the simulation,
being just basic enemies that may be also trapped in the simulation.


**Health Bar**  
<img width="366" height="61" alt="image" src="https://github.com/user-attachments/assets/3c3899c2-a69b-4397-9a68-1fd7c2166b9d" />  
Created Animation for health bar changing, and designed health bar in aseprite to fit with the game style.


**Crosshair and reload animation**
<img width="2023" height="90" alt="crosshair_reload" src="https://github.com/user-attachments/assets/2d05a8ee-817f-482e-9aa4-e047c595bd84" />
Created dynamic crosshair reload animation so that the time for the animation lines up with the guns reload time.  

  
**Create a visual for explosions**  
<img width="487" height="614" alt="image" src="https://github.com/user-attachments/assets/ba5a9bbb-74bf-47b2-8685-7b335c6a1d7a" />  
Created a visual explosion such that players could see the radius of rockets, using godots internal node system rathen than a png.
This was created with help of AI assistance, to help create the visual using godot's code.


**Create asset for rockets**  
<img width="974" height="258" alt="image" src="https://github.com/user-attachments/assets/6d179324-baff-46e1-9266-5d47562f14ab" />  
Created the asset for the rockets in aseprite.


**Create Dynamic Heat Bar**  
<img width="321" height="108" alt="image" src="https://github.com/user-attachments/assets/ea897ae5-cafd-47fd-83ff-7e1136c4fdaa" />  
https://github.com/brianli378/ecs179-final-project/blob/b4ef9fe949e6a1a82833548e59537d87f5a57b8d/2d-roguelike/scenes/heat_bar.gd#L1-L64  
Created a dynamic heatbar so that players would know the current heat status of their weapon  

**Import Font to fit Pixel Art Style**
Used a open source minecraft font to make the games text fit the pixel art aesthetic. [Pixel Art Font](https://www.dafont.com/minecraft.font) 
  

## Game Feel  
Here I mostly focused on having the game *feel* fun to play, with having the aiming be fun and not limiting, and the game to be semi balanced so it
wasnt too difficult or too easy. I also tried to make most of the guns viable (with fusions being better than base guns), though some fusions
definetely are better than others. This is fine, as part of become better at the game is discovering what works for your playstyle and what doesn't.

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


**Adjusted Sniper and Pistol Gun Damage**  
Adjusted sniper damage to one shot, and for pistol damage to be higher in order to contest with full auto/explosion guns.


**Scaled damage inflicted on player** 
Scaled the damage inflicted on player so that the player (at the start) does way more damage to enemies then enemies do damage to the player.
This is to allow the game to be a bit easier at the start as the player adjusts, but still have some scaling as the player adjusts to the game and/or gets a better gun.


**General adjustment of gun values** 
Tested out most of the guns to see if they were viable, and adjusted values accordingly. This included adjusting the spread, the damage, the reload speed,
the recharge speed of some laser guns, projectile speeds, and many other small adjustments. 


**Adjustment of Laser Weapons**  
https://github.com/brianli378/ecs179-final-project/blob/9bc012d87b1f506ba7cb577ff9827f84df922752/2d-roguelike/scripts/guns/fusion_guns/laser_gun.gd#L1-L94  
Changed laser weapons to be unique, rather than having a reload they have a heat mechanic. 

****

## Other Contrubutions

**Designed All of the fusion guns**
[Fusion gun design document](https://docs.google.com/document/d/1bNHDFz7tdk0n9OXliNgc_nxGdNC5oqgv6N0_m0_iOEU/edit?tab=t.0)
Designed every gun fusion, including stats, inspiration images, and other game examples.

**Created the Slide for the Presentation**

**Wrote the description on how to play the game in this document, and formatted this document.**
  

# Brian Li - [github](https://github.com/brianli378) #
## Game Logic
My main role was Game Logic. Throughout development, my main focuses on the project were the logic and implementation of the core gameplay systems, including player logic (movement, aim, dash), camera logic (2d lerp camera, camera shake), reload logic, inventory logic and fusion logic. 

**Player and Camera**

The player is implemented as a CharacterBody2D with movement and a dash mechanic. The player script reads and responds to the basic WASD user input and "looks at" the global mouse position. On top of basic movement, I also implemented a smooth dash mechanic. When the dash input is pressed, velocity is boosted in the direction the player is moving then decelerates back down to the normal movement velocity. The smooth acceleration and deceleration on the dash make the player movement feel more fluid, and combined with the 2D lerp camera provides a polished movement experience for the player.
https://github.com/brianli378/ecs179-final-project/blob/a34c228d4fc5f65937dfd0f47e620f07dc98f666/2d-roguelike/scripts/player.gd#L67-L99

I also implemented the camera behavior. Instead of the default 2D position lock camera, I drew inspiration from exercise 2 to implement a 2D version of the 3D lerp position lock camera from the assignment. I also added a camera screen shake function called by the gun manager any time a gun is fired. The add_shake function works by choosing a random offset for x and y between -1.0 and 1.0 and applying it to the camera. The function also takes in a float shake_multiplier as input, allowing adjustable shake intensity for different guns.
https://github.com/brianli378/ecs179-final-project/blob/a34c228d4fc5f65937dfd0f47e620f07dc98f666/2d-roguelike/scripts/position_lock_lerp_camera.gd#L11-L47

**Ammo and Reload**

When the guns were first added, there was no existing ammo system so all guns could be shot for as long as possible without the need to reload or worry about ammo. I implemented the ammo and reload system inside the gun manager and also added a gun spec file which kept track of the magazine size, starting reserve, max reserve and reload of each weapon. When the player shoots, ammo in the current magazine gets decremented. If the magazine is empty and the player tries to shoot, an auto reload system automatically begins a reload for the player. I also implemented a manual reload triggered by pressing “R” in case the player is low on ammo and wants to reload before getting into a fight. 
https://github.com/brianli378/ecs179-final-project/blob/647016933854a99de688c1d6553265ed6472b780/2d-roguelike/scripts/guns/gun_manager.gd#L201-L210

To support the reload system, I implemented a CanvasLayer into the game for the player’s HUD. The script would read the current gun key and pull the ammo in the player’s current guns magazine and reserve, displaying them in the standard mag/reserve format. A reloading label also appears whenever the player begins a reload, providing a heads up so the player knows they can’t shoot during that time.

**Inventory**

The player could cycle through the different guns they were holding, but there was still no way to display all the guns. We also needed somewhere to perform the fusion, so I was in charge of creating the player’s inventory. On button press, a CanvasLayer that contains the inventory appears with containers for each of the player’s weapons. This inventory_ui.gd script connects to the GunManager and reads its gun_keys to determine which weapons the player currently owns. The inventory then dynamically displays those guns for the player. This inventory system was also the base of which I built the fusion system on.

**Fusion**

To implement the fusion system, I built on the existing gun logic that Alex worked on. The GunManager had a collection of guns identified by string keys for both base weapons (ex: "pistol", "machine gun", "sniper", etc) and fusion weapons ("laser machine gun", "pachine gun", etc). I added the fusion recipes, a mapping from pairs of gun keys to a resulting gun key, and mapping from those fusion gun keys to the actual gun classes that Alex had created. In the inventory UI, I added a fuse button and selection logic. In my original implementation, the player would begin fusion by pressing the fuse button, then click on any two guns in the inventory and press the fuse button one more time to finalize the fusion, removing the consumed weapons (along with their ammo entries) and adding in the new fused weapon into the player inventory. It then initializes the new fusion gun's ammo.
https://github.com/brianli378/ecs179-final-project/blob/4e8256ea982b27de25fe8364207538a7d8c02e59/2d-roguelike/scripts/guns/gun_manager.gd#L300-L355


## Gameplay Testing and Other Contributions
My secondary role was Gameplay Testing. Along with constantly testing and iterating on my own implementations to make sure they were bug free, I also spent time handling bug fixes that popped up during development. A few notable examples are:

**Weapon swap and fire timing:**

After the weapon implementation, there was a bug where every time the player switched guns they had to wait _time_since_last_shot until they could shoot the gun they switched to. While this had minimal effect on guns like the machine gun that could shoot very quickly, it could clearly be felt when switching to a sniper or rocket launcher and having to wait a few seconds before being able to shoot the first bullet. I fixed this by resetting the timer on gun switch, making the gun swapping feel a lot more responsive.

**Reloading during fusion:**

After implementing the fusion system, I ran into a bug where if you reloaded a non-fused gun then fused it and switched to the newly fused gun, the game would completely crash. This was due to the reload logic from guns that no longer existed being accessed. I fixed this by adding safeguards to values accessed in the gun manager.

**Boss dropping duplicate guns:**

One of our core game mechanics is that the boss drops the player new base weapons which the player can then use to fuse new weapons. While playtesting one day, I ran into an issue where when I killed the boss with a machine gun I would receive way more than the regular 2 guns I was supposed to receive. This ended up being due to the enemy _handle_death function being called multiple times upon boss death. The fix to this was pretty simple, I just moved the _is_dying guard from the bottom of the function to the top so it would return instantly and no longer provide multiple duplicate guns.

**Player hurt sound played nonstop when hit by a rocket:**

This was another issue that emerged when playtesting. The player's hurt sound was being played repeatedly forever whenever the player got hit by an enemy rocket. The damage sound was played whenever health_bar.value > health and health_bar.update_health(health) was called after. Regular bullets use integer damage but the rocket used float damage and the health_bar was also integer based, so when the player got hit by a float damage rocket and the health dropped to a float number (for example, 7.7), the health bar value would still update to integer 8 so it would loop 8 > 7.7 and play the sound forever. I fixed this by rounding the player damage taken to an integer.



# Sean Weber - [github](https://github.com/Septro31-SeanWeber)#
## Map and Level Design/Control

**Base Map Design, Collision Tile Settings**
(2d-roguelike/scenes/maps/maps.tscn)
Created Base Map Layout of 3 main rooms, the Boss Map, and the Start Map. Each of these maps uses collissions set in TileSet, with specific tiles being collision tiles while others being movable. This delineated the floor versus the walls. The design used was based on a cyberpunk city look, with blue brick walls and tiled floors with vents, which matches the simulation look with an almost dungeon aesthetic. I tested the map creation against player movement and also determined the size of walls, needing to increase the tile size so as to not slow the game down from enemy pathfinding. Furthermore, the size of the walls were created to fit the bullet spawnpoint as best as possible for weapons. While some weapons still can shoot through walls (Rocket types are the main ones), most bullets were prevented from shooting out of the map. This utilized class materials in creating tile maps and layers, as well as implementing collision boxes for them.

**Stylizing for all Map Zones and Sections**
(2d-roguelike/scenes/maps/maps.tscn)
The Start Zone was created to effectively provide a breather between rounds in which the player is given the time to fuse newly collected guns and try out the guns they have so far without danger. In the Base Map, the goal was to not create a map that wasn't just a bullet hell of enemies while also not feeling exactly linear in gameplay. As such, the Base Map contains 3 medium sized zones that contain enemies with pathways between ever zone. The Boss map contains 4 corner L shaped objects which is used as safe areas for the player to not get shot by the Boss, which takes control of the middle area very quickly. The Boss Design was intentional to force the player to the edges of the map to put the player on a back foot against the bosses, as the boss design made being in the middle near impossible with their size and weapon. Final note for the Safe Zone, since there is a teleport location, I used the different floor designs to indicate the natural flow of the player into the teleportation zone. These used design decisions to make a clear and challenging game.


**Implementing of Zone control to handle enemy spawning**
[enemy zone trigger](https://github.com/brianli378/ecs179-final-project/blob/fa73743499acabbb05abc331016b22b0eb813da9/2d-roguelike/scripts/menus/enemy_zone_trigger.gd#L1)
[start zone trigger](https://github.com/brianli378/ecs179-final-project/blob/fa73743499acabbb05abc331016b22b0eb813da9/2d-roguelike/scripts/menus/start_zone_trigger.gd#L1)
There were 2 styles of zones created for the maps, teleport zones and enemy spawn zones. By using a map controller that attaches to the main maps scene, I provided a state enum that would determine the current stage that the map was in (Safe, Base, or Boss). Then, each type of zone had on body entered signals that would handle how to deal with the zone. For spawn enemies zones, it spawns enemies based on the set list of enemies created in the zone, and teleport zones send a signal to the main game to teleport the player to a location. This utilizes the signal pattern to effectively communicate between parts of the game.

## Narrative Design

**Updates for Story**
(Not directly related to code specifically, mostly in how to explain the nature of our game in our 1 paragraph pitch and the title to match the story and themes)
With the established stretch goals that we had for the game, we all agreed upon a cyberpunk feel. With this interpretation, the initial idea was to have a common
night life within the cyberpunk 2077 universe with you effectively moving around and 
fighting the enemies, which would be cops. However, as I was designing the map and how teleportation between maps would work instead of a fully linear path to take, 
I realized this didn't make much sense as to what the story was suggesting. Because
of this, I knew a simulation sort of story would make sense instead. In tandem, there
would reasonably be some entity or entities that trapped the player in here. With 
the ability to fuse guns, it's likely that this simulation is to test these guns by
taking the player and constantly pushing them to their limit.

**Final Interpretation and Implementation of story within game**
With the teleportation nature and how the enemies spawn and scale, we went for a simulation story with an unknown company. Even though we all know that the company is effectively testing the gun fusion and how powerful these guns are, we don't inform the player of this. This is mostly because in reality, the player shouldn't actually need to know what is happening. Instead, we decided to provide the big hint about the nature of the game: the title being Simulacrum. This word is similar in nature to simulation, representing something created that is fake. With this in mind, with the teleportation, it is obvious that with the cyberpunk feel that most likely some company is pulling the strings here. What they are doing specifically is left for the player's interpretation to enjoy decyphering the nature of the game, but the intention is that the company is testing their fusion guns, which is supported by how defeating boss provides guns to the player to test new ones, while forcing you to create new fusions to survive as the max inventory is enforced by removing older guns. Finally, clear pathways to sections indicate the existence of some outer entity controlling where they want you to move.

## Other Contrubutions

**Teleportation between Maps to control round movement**
[map controller (other members worked on scaling enemy difficulty within this class)](https://github.com/brianli378/ecs179-final-project/blob/fa73743499acabbb05abc331016b22b0eb813da9/2d-roguelike/scripts/map_controller.gd#L1)
[enemy death signaling and handling for round control](https://github.com/brianli378/ecs179-final-project/blob/fa73743499acabbb05abc331016b22b0eb813da9/2d-roguelike/scripts/map_controller.gd#L139)
Teleportation is controlled partially by zones, but they are also controlled by some round movement by identifying the number of enemies on the map, and for the safe zone, just the regular teleportation zone code. I've already explained the teleport zone code, which effectively just signals the base game with a location to teleport the player, but the map controller also uses these signals after killing enemies to teleport between zones as well. Given the fact that the enmy spawn zones have the same code for both the Boss Map and the Base Map, they also function in the same way with the map controller in identifying teleportation. This is done by also adding to a number of enemies that is maintained by the map controller. On any enemy death, the dying enemy notifies the map controller, and the map controller decrements the number of enemies by 1. For both the Boss Map and the Base Map, all zones are populated and add to the map controllers at the same time. This ensures that the Base Map, which contains multiple zones, doesn't teleport the player prematurely if no enemies exist on the map, even though some zones haven't spawned enemies yet. Finally, once the map controller sees that the number of enemies goes to 0, the map does a calculation based on the current stage as to whether a simple teleportation is needed or if the next zones need to be populated with enemies. This used a control design pattern that served as an intermediary between the main game class and the lower level zones to handle both round spawning and teleportation.

**Spawning enemies and bosses within the maps**
[base enemy spawn settings](https://github.com/brianli378/ecs179-final-project/blob/fa73743499acabbb05abc331016b22b0eb813da9/2d-roguelike/scripts/map_controller.gd#L98)
I provided code that spawns enemies within the maps as well as populates the relavant spawn points and enemy specifications. The setting of the populated enemies is based on the current stage of the map controller. These functions was utilized by the round management developer to add scaling based on the round of the map controller to make the enemies scale in difficulty and damage. This code was also used by the Boss developer to spawn the boss during the boss stage. The spawn enemy zone is utilized in both basic enemies as well as boss enemies since both are types of a higher level class hierarchy of enemies, and as such there was no need to duplicate code. This utilized the enemy factory pattern in a way by storing enemy specs within the controller design pattern.

**Pushing out guns to enforce a max size**
[adjustment for background colors of removed guns in next round](https://github.com/brianli378/ecs179-final-project/blob/fa73743499acabbb05abc331016b22b0eb813da9/2d-roguelike/scripts/ui/inventory_ui.gd#L256)
[remove guns from front to match max of 6 inventory slots for guns](https://github.com/brianli378/ecs179-final-project/blob/fa73743499acabbb05abc331016b22b0eb813da9/2d-roguelike/scripts/enemies/enemy.gd#L99)
One issue we ran into with the inventory systems was getting too many guns would lead to the gun inventory pushing out the fusion ui, making fusion at somem point impossible. This was gauranteed to happen since there was no way to remove guns from the inventory, which also made the game slightly boring since you could just fight forever and potentially lose your fusion ability, which is the main purpose of the game. To combat this, I designed a way to delete from the inventory that is out of the control of the player. This helps add difficulty since guns will be deleted in such a way that makes the player need to use the newly collected weapons. The method to do this is to identify the maximum inevntory size before the fusion ui moves into an odd location, and then if this size is exceeded, you pop out the front of the gun inventory list until you are within the maximum inventory. Popping from the front is key since it means the guns that have existed for the longest get deleted from you inventory, which means you constantly have to create new combinations and even the as the game progresses those new combinations will at a point get deleted, and a new combination will need to be used. This enforces variety in the guns you have access to. To indicate which guns will get deleted in the inventory, I added an extra visual to indicate based on the current inventory which guns would get deleted in the next round by highlighting the slot in red. This was mostly for game clarity and to ensure main functions in our game were accessible.


**Documentation for contributions to the project outside of the main and sub roles.** 

# Aditya Sharma #
## AI and behavior designer

**General Functionality**

I implemented movement for the enemies, their combat behavior, and modified the player gun manager to work as an enemy gun manager and kept it up to date with changes to the gun system. 

[Enemy Functionality File](https://github.com/brianli378/ecs179-final-project/blame/56d12f68b7984a7a77158215ab2e52038ea6f184/2d-roguelike/scripts/enemies/enemy.gd)

[Enemy Gun Manager File](https://github.com/brianli378/ecs179-final-project/blame/56d12f68b7984a7a77158215ab2e52038ea6f184/2d-roguelike/scripts/enemies/enemy_gun_manager.gd)

I built the functionality for enemies and the player to take damage and die through the _on_body_entered() signal and collision layers/masks, also ensuring that there's no friendly fire by modifying the projectile spec to track who fired the projectile. 

https://github.com/brianli378/ecs179-final-project/blob/56d12f68b7984a7a77158215ab2e52038ea6f184/2d-roguelike/scripts/guns/projectiles/projectile.gd#L26-L42

**Enemy Behavior**

My goal with the enemy behavior was to center it around the guns themselves, since the main aspect of our game is the gun system. I knew that enemies with different guns would want to use them in different ways, for example, an enemy with a shotgun would want to get closer to the player than one with a sniper. To implement this, I gave each enemy a close leash and far leash and wrote logic for the enemy to approach the player when the distance is > the far leash, and move away from the player when distance is < the close leash. This resulted in an engaging tug of war that was fun even in an empty room with no cover. 


**Enemy Line Of Sight**

To deal with cover, I implemented line of sight (LOS) for the enemies through a ray cast 2d object attached to the enemy gun manager. I learned how LOS typically worked in Godot through this tutorial: https://www.makeuseof.com/godot-raycast2d-nodes-line-of-sight-detection/, and adjusted the map tileset's collision masks to ensure only walls would block LOS. Then I integrated the basic enemy behavior by ensuring the enemies only shoot at the player when they have LOS.


**A\* Navigation**

With LOS working, I needed a way to have the enemies navigate around obstacles to regain LOS with the player when an obstacle was blocking them, which led me to A* navigation. I learned how to implement this in Godot through this tutorial: https://www.makeuseof.com/godot-raycast2d-nodes-line-of-sight-detection/, and modified the details to work for our structure. Particularly, I found the tutorial's suggested code performed very poorly, which I will expand upon later. I once again modified the map tileset by painting a navigation layer on the tiles for the floor to inform the navigation agent on what it can use for pathing. I also implemented tutorial code to identify all obstacles in the level based on collision polygons.

The A* navigation succeeded in enabling the enemies to regain LOS with the player, but I noticed they initially got stuck against the obstacles and slowed down to a halt while grinding against the walls. I identified this issue as being due to navigation tiles being so close to the wall and the shape of the collision object being a square. To mitigate this I changed the collision object to an oval, which fixed the issue for the most part but not around corners. I found I could implement a navigation server and create meses away from the wall to prevent this, but unfortunately did not have time. Instead, we modified the edges of the corners to be a bit more rounded to help with this issue. 

I decided to speed up the enemies while they were in A* navigation to help reduce the effect of sliding against collision objects like walls, and keep the gameplay engaging and urgent. Both the A* and LOS behavior together also resulted in enemies utilizing cover to shoot at the player, which made the combat more realistic and made the player's positioning relative to obstacles more relevant. 


**Fusion Weapons For Bosses**

To come up with an engaging boss design, I proposed some options to the team and discussed with Sean and Alyssa. 

To differentiate the bosses from basic enemies, we decided to make them larger, have more health, and use fusion weapons to showcase some more combinations to the player. On death, the boss also gives the two weapons used to make its fusion to the player. I implemented all of this, and had to make some significant adjustments to the fusion system for the player to let it work for the bosses. I also fixed a bug where the player could not fuse these weapons received from the boss due to the way the fusion system worked.

First, we chose a smaller pool of weapons for the bosses to pull from to ensure the experience was polished before adding in more bosses. We made our decision through team discussino, but generally tried to give the player a good variety of weapons to experience fighting against. The fusion weapons needed unique tuning to the boss in terms of sprite position and projectile spawn position compared to the player, which I determined through trial and error. I also noticed some issues with the LOS and pathing compared to the normal enemies, which were mitigated by attaching the LOS ray to the eye position of the enemies, which made them act more realistically based on whether their eyes could see the player. To deal with the pathing, I made the boss smaller as suggested by Alyssa.


## Performance optimization

**A\* Pathing**

After implementing A* pathing, I immediately noticed a significant performance drop with multiple enemies. I first utilized the profiler to confirm this was due to the pathing, and found two issues to solve. First, the tutorial's method for calculating the obstacles and marking them for the navigation agent was very slow due to it using a list for storage, I checked with an LLM to confirm how to optimize the code as Godot doesn't have a Set data structure which I wanted to use, and replaced the list with a dictionary for faster lookup. 

This significantly improved performance, but the other issue was the small tile size. I realized this through online research, and believe it's due to the density of the mesh the navigation agent must traverse to find the shortest path to the target. I wasn't sure if this was the fix, but I suggested increasing tile size which Sean helped with, which solved the problem.


**Gun instance caching**

I noticed that the enemies and player were rebuilding gun objects which could be shared between them, so I added a variable in our GunData resource to cache the gun objects for reuse, reducing memory usage.


**Enemy Death Signal Chain Optimization**

When refactoring the enemy code, I noticed that the enemy death tracking done by the round manager (in map_controller.gd, and set up in the enemy factory) was receiving signals indirectly through game.gd, which received on death signals from the enemy, instead of map_controller directly receiving the on_death signal emitted by enemies. I removed game.gd from this process to improve performance through reduced code execution and fewer signal emissions/handles. 


**Reduced game overhead and improved gameplay through design choices**

I proposed each weapon type sharing ammo across weapons to encourage player to fuse new weapons rather than have multiple of the same weapon, which allowed us to simplify the gun system by not needing each weapon instance to track it's ammo. This also enabled the gun object caching mentioned earlier. 


## Other Contrubutions

**Menus**

I followed a Godot tutorial (https://docs.godotengine.org/en/3.0/getting_started/step_by_step/ui_main_menu.html) to learn how to design the UI for the main menu and did my own research to understand how to link the images to buttons to allow for menu and scene switching to create this flow:

main menu -> controls menu -> game -> either pause or death menu -> game

I also had to make sure to clear the scene tree of all leftover nodes when switching between some of the menus to ensure there would be no overlapping visuals or logic. 

I fixed a few bugs here concerned with the player being able to pause at the same time as they die and thus seeing both the pause and death screen at the same time. I realized this was due to the queue_free() of the player node not executing immediately (because its queued to free at the end of the current frame), so I implemented a flag which prevents _physics_process() runs after the death handle function is triggered. 

I also ran into an issue where projectiles and enemies were still showing up on the pause/death screens despite the scene tree clearing I was already doing. I realized this was because those nodes were not part of the same tree as the player and UI and the map, so clearing the game scene tree wasn't enough, and modified the clearing to accomodate this.

[Commit Fixing Pause Projectiles](https://github.com/brianli378/ecs179-final-project/commit/4aec400f7194284c4a9209a87f844d8b75d82056)

I also learned how to pause the scene tree and unpause it, but this is built into Godot so it was easy to implement.

Please note the look of the menus (especially the title screen) were Alyssa's work, I mainly worked on the functionality and backend of the menus. 


**Linting**

I set up a Godot linter (https://github.com/Scony/godot-gdscript-toolkit) through Github actions to help the team adhere to best practices and the GDScript style/format guide. The linter was set up to run on just pull requests to ensure we didn't use too many credits, and allow for small discrepencies in formatting before the review process.

https://github.com/brianli378/ecs179-final-project/blob/b16f086c586f394d463f21e81ac46b5093dc1411/.github/workflows/gdlinting.yml#L1-L15


**Code Refactor**

I refactored the file structure to separate scenes from scripts from specs completely, and added in folders to organize files more logically to improve codebase quality.

**Playtesting**

To ensure enemies were behaving as they should, I did a lot of playtesting, which helped me suggest balance changes such as the rocket sniper being too weak, the laser machine gun being too strong, and the base sniper being too weak. I also found bugs like the player still shooting when in the inventory menu and rockets not triggering impacts when the player walks into them from the side.

I balanced some of these myself such as increasing the projectile speed on machine guns to make them feel more responsive to the player.

Some of the tuning I worked on included speed of enemies, enemy distance to player, fire rate, and sprite and projectile spawn positioning. [Commit Example of Tuning Changes](https://github.com/brianli378/ecs179-final-project/commit/4491b040077d8f0db918d26ad54cbbbc0c1c4174#diff-fac714f53a51c354668a6c5b8169d6125dfa8d820bd9073bbfa54ad1cb64a7ee)

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


# Invasive Species GDD
Pirate Software Game Jam 14  
January 2024  
By Baro
## Introduction
You are an invasive species that must expand and overwhelm the local ecosystem.
### Inspiration
#### Vampire Survivors
Simple control scheme and waves of enemies
### Player Experience
The player defeats waves of enemies to unlock upgrades that will allow them to take control of the entire map. Experience is gained after each run that can be spent on improvements to the character, allowing the player to advance further in subsequent runs.
### Genre
Single Player, 2D, Action Roguelike
### Target Platform
Linux and Windows PC
### Development Software
- **Game Engine:** Godot 
- **Source Control:** Github
- **Sprites:** Aseprite
## Concept
### Gameplay Overview
The player controls a single character that can be accompanied by many lesser creatures that follow the player and attack nearby enemies. As the player levels up the number of follower creatures increases. Upgrades can improve the Player character or the followers in various ways.
### Theme Interpretation (It's Spreading)
Interpreted as one force overwhelming another. In this case, the invasive species is increasing in size and power, overwhelming the local ecosystem as it tries to fight back.

This is reflected in game by the increasing numbers of follower creatures helping the player, along with the change in the background as bosses are defeated.
### Gameplay Mechanics
#### Auto Attack
The player character automatically takes a swing at nearby enemies periodically. Upgrades can increase the size, damage, or interval of the attack.
#### Contact Damage
Enemies that make contact with the player will periodically cause damage to them until they are destroyed or the player moves out of range.
#### Obstacles
Walls and other objects in the field can block movement of the player and enemies. Some obstacles (like water) only block the player until they unlock a specific trait during a run.
#### Enemy Spawns
There are 2 types of enemy spawning. The first is a constant generation of enemies just outside the camera view. These enemies immediately track towards the player. The type of enemy is determined by the duration of the run, progressively more powerful enemies are spawned.

The second is a wave spawn. These occur on set intervals and will generate a large number of enemies at once.
#### Followers
Smaller versions of the player character that will roam around the player and defend them from enemies. These followers can be upgraded or modified by various means.

Followers will attempt to form a perimeter around the player to protect them from enemies.
#### Dens (Control Points)
Dens are scattered across the map and act as Control Points for victory in a given run. Dens start under enemy control and will generate enemies while building up to a boss spawn. Destroying a Den before its Boss spawn is ready will prematurely spawn the boss with reduced health.

Once the Den is destroyed and its boss defeated the Player will gain control of the Den. Dens under player control will spawn allied creatures that will roam from the Den and fight enemies.

Some Dens (or groups of Dens) will unlock additional effects for the player once they are controlled. Things like controlling 3 Dens on the river edge will unlock swimming.
## Game Experience
### User Interface
UI shows the experience bar across the top of the screen. A list of current powerups to the side. A timer for the duration of the current run.

Player health is shown under the players sprite in the middle of the screen.

Game over screen displays tallies of enemies, bosses, and dens defeated.
### Controls
- **Movement:** Arrow keys / WASD
## Art
// TODO
## Theme Interpretation
// TODO
### Design
// TODO
## Audio
### Music
// TODO
### Sound Effects
// TODO
## Future Elements (Out of scope for Game Jam)
### Meta Upgrades
Player gains points for levels gained, enemies slain, time survived (or lower time if victory), area controlled, etc from each run. These points are then spent on upgrades that apply to the character at the start of all subsequent runs. 

This also acts as a difficulty slider, allowing players that are struggling to accumulate power even on failed runs and eventually win.
### Different Characters or Customisation
Unlocks that change the playstyle and visuals of the character. Unlocked through points (meta upgrades) or through sequences or secrets in game runs.

Could change the starting abilities of the character (swimming, flight, health pool, etc) and/or the attack style (AoE effect, projectiles, follower style, etc).
### More Maps and Story Progression
Additional maps that introduce gameplay elements and progress a story as the character overtakes the ecosystem.
## Development
### Task List
| Task | Type | Status | Completion Date | Notes |
| ---- | ---- | ---- | ---- | ---- |
| Design Document - Initial Draft | Documentation | Complete | 15/1/24 |  |
| Project Creation - Create Godot Project, Init Git repo | Project Management | Complete | 13/1/24 |  |
| Create Main Menu - Transition to Game View | Coding | Complete | 13/1/24 |  |
| Select Assets for Player, Enemies, Environment | Art | Complete | 14/1/24 |  |
| Create Player Character - Basic Movement | Coding | Complete | 14/1/24 |  |
| Player Character - Auto-attack | Coding | Complete | 15/1/24 |  |
| Create Basic Enemy - Movement, Player Interaction | Coding | Complete | 15/1/24 |  |
| Create Enemy Spawning System | Coding | Complete | 15/1/24 |  |
| Combat Text - Floating Damage Numbers | Coding |  |  |  |
| Experience Bar and Level Up | Coding | Complete | 16/1/24 |  |
| Game Loss State and Restart | Coding | Complete | 15/1/24 |  |
| Player Upgrades - Experience and Level Up | Coding | Complete | 15/1/24 |  |
| Player Upgrades - Pack Animals (Followers) | Coding | Complete | 19/1/24 |  |
| Create Boss Enemy - Movement, Attack Pattern | Coding | Complete | 20/1/24 |  |
| Add Boss Spawns to Spawning System | Coding |  |  |  |
| Design Document - Finalise Submission Version | Documentation |  |  |  |
| Create submission build | Project Management |  |  |  |
| Followers interact with Enemies | Coding | Complete | 19/1/24 |  |
| Dens - Spawn Enemies | Coding | Complete | 20/1/24 |  |
| Dens - Damageable, Spawn Boss | Coding | Complete | 20/1/24 |  |
| Dens - Capturable, and Follower Spawning | Coding | Complete | 20/1/24 |  |
| Victory Condition - Destroy/Capture all Dens | Coding | Complete | 26/1/24 |  |
| Update follower tracking - leads player | Coding | In Progress |  | Using Player for enemy detection helps |
| Map - Create outer perimeter walls | Game Design | Complete | 26/1/24 |  |
| Map - Create inner map layout, place Dens | Game Design | Complete | 26/1/24 |  |
| Game Feel - Add effects to attack/death | Design |  |  |  |
| Game Feel - Background music | Audio |  |  |  |
| Game Balance - Change Dens to continue spawning bosses if left unclaimed (reduce later den HP) | Coding |  |  |  |
| Add a "how to play" section to title screen, explain capturing dens | Game Design |  |  |  |
| Add credits page  | Coding |  |  |  |
### Work Log
#### 2024-01-13
- Brainstormed ideas for Game Jam
- Created Design Document
- Created Godot Project and set up Git
- Created Main Menu and buttons for quit and start game
#### 2024-01-14
- Found suitable animal sprite sheet
- Created Player, added movement and animations
- Started Player attack functionality, no animation but will destroy enemies
- Added basic enemy (Mouse), with animations and tracking to move towards Player
- Changed scene background to a flat green and added some Tree obstacles
#### 2024-01-15
- Created a simple 3 frame claw swipe animation in Aseprite
- Added swipe animation to Player attack and fixed hitbox to match
- Cleaned up collision interactions between player, enemies, environment, and their respective hitboxes and hurtboxes
- Added damage to player when enemies get close
- Enemies constantly spawn off screen and approach the player
- Game Over screen when player health reaches 0
#### 2024-01-16
- Added exp bar and level at top of screen, enemies give experience on death
#### 2024-01-17
- Updated documentation with concept for Dens and area control game objective
#### 2024-01-19
- Created Followers, will try to stay near the player and attack enemies that come within their attack range
#### 2024-01-20
- Created boss enemy
- Created Den structure
- Dens spawn enemies periodically until destroyed
- Dens will summon a boss after a timer, or when destroyed. The boss has reduced health based on timer
#### 2024-01-21
- Added Tilemap for creating level background, added impassable walls
- Changed follower detection to use area around player rather than themselves (makes followers feel more like they are defending the player)
#### 2024-01-22
- Expanded size of map, added more Dens, adjusted timers and stats of Dens to make them more difficult the further from the start point they are
#### 2024-01-26
- Finished Map layout and configured Dens to stagger boss spawns
- Updated Follower AI to better track nearby enemies
- Added kill stats to game over screen
- Added victory condition check and victory screen

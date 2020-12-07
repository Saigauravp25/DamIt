# DamIt README (Group 13)


View this README document on our GitHub for proper formatting: https://github.com/kishansol/DamIt/blob/master/README.md


## Members
  * Saigaurav (Sai) Purushothaman
  * Kishan Solanki
  * Nikhil Bodicharla
  * Nirav Lalsinghani

## Comments
  * Please run this app/game on a real device to get the best performace. Any iOS device or model is supported.
  * Test account set up with progress of levels - username: test@gmail.com, password: test123
  * Test account with all levels(so far) unlocked - username: he@gmail.com, password: test123
  * No single player levels past level pack 2 currently 
  * No co-op levels past level pack 1 currently 
  * Multiplayer mode not implemented - stretch goal


### Dependencies
 * Swift Version: 5.0
 * Xcode Version: 12.0
 * Firebase DataBase
 * Firebase Analytics
 * Firebase Auth
 
 ### Frameworks
  * UIKit
  * SpriteKit
  * CoreData
  * AVKit
  * Firebase 

### Features 
|Feature | Description | Release Planned | Release Actual | Deviations | Contributions|
|---------|---------------|---------------------|-------------------|--------------|-|
Splash Screen | Animated splash screen while app loads | Alpha | Alpha | N/A | Nikhil (100%)
Sound Effects | Sounds when preforming actions | Alpha | Alpha |  N/A | Sai (100%)
Game Logic | Game mechanics, move character and toggle log. Level encoding and decoding. | Alpha | Alpha |  N/A | Sai (100%)
UI | Have App UI Built | Alpha | Alpha | N/A | Kishan (30%) Nikhil(20%) Nirav (10%) Sai (40%)
SpriteKit Physics and Animations | Inlude physics and animations for resetting a dam/level, character movement, and a layered starfield animation for the sky  | Beta | Beta | N/A | Sai (100%)
Firebase Integration | Have all user data saved via firebase | Beta | Beta | N/A | Kishan (70%) Nikhil (30%)
Assets | Music,  beaver images, and other essential graphics for games | Beta | Beta | N/A | Nirav (40%) Sai (40%) Kishan (20%)
Firebase Authentication | Login and user authentication | Beta | Beta | N/A | Nikhil (100%)
Tutorial Mode | Interactive tutorial for gameplay | Stretch | Beta | N/A | Nirav (100%)
Game Settings | App settings toggles for the user | Beta | Beta | N/A | Kishan (85%) Sai (15%)
Level Creation | Two level packs designed and created for single player, and one level pack for Co-Op | Final | Final | N/A | Nirav ( 70%) Sai (10%) Kishan (10%) Nikhil (10%)
Co-Op Mode | Allow user to play with two characters at once | Final | Final | N/A | Sai (80%) (Kishan 15%) Nikhil (5%)
Beaver Skins | Have different skins for user to pick from | Final | Final | N/A | Nirav (80%) Sai (20%)
Background Music | Optional music playing in the background | Beta | Final | N/A | Sai (100%)
Ranking System | Allow each level to be ranked based on users moves| Beta | N/A | Ranking was closely tied to Game Center and was scrapped when Game center integration would not be possible | N/A
Undo Functionality | Allow user to undo a step | Beta | N/A | was decided it would make game too easy and later scrapped | N/A


### Contributions
#### Kishan Solanki - KS46487 (30%):
  Alpha - (25%)
  * Core Data for Level Storage 
  * Building out Application UIViews w/ Delegates
  * Merging App Navigation Repo w/ Game Repo
  * NSUserDefaults for User Settings + Custom Skin Preferences
  * GameCenter Functionality that was later scraped
  * Designed multiple Levels
  
  Beta - (25%)
  * Backround images for view controllers
  * implemented FirebaseDataBase level data for additional level support
  * implmented local notifications tied to notification toggle 
  * Piped game control to include new level pack data
  
 Final - (40%)
  * Fixed UICollection View Bug
  * Added Firebase saftey so user can not progress past levels stored in firebase
  * Enable new levelpack buttons as user data progresses
  * Add Co-op level data to Firebase
  * Add settings data integration to firebase
  
#### Saigaurav Purushothaman - SP43976 (30%):
  Alpha - 50%
  * Coded fully functional Console Application of the Game (Block, Player, and Level Classes)
  * Sourced or Created necessary Assets such as Images, Logos, and Sounds for SpriteKit
  * Implemented remaining GameComponents
  * Ported Console Application to SpriteKit (GameViewController, GameScene, and GameComponents)
  * Implemented SKPhysics and SKActions (Sound Effects) for SpriteKit
  * Created custom Animations using SpriteKit
  * Added Swipe Controls for the Game
  * Built User Interface for GameViewController and GameScene
  * Created necessary Types and Utilities
  * Devised and Implemented Level Encoding and Decoding Scheme for Ease of Level Creation and Storage
  * Designed multiple Levels
  * Added Constraints to all Views
  
  Beta - 15% 
  * Implemented SoundFX Toggle
  * Added Character Skin Customizability
  * Set Constraints on all new Views
  * UI Enhancements
  
  Final - 25% 
  * Co-op Mode Game Logic and Functionality
  * Background Music Implementation
  * Bug fixes
  
  #### Nikhil Bodicharla - NB24499 (23%):
   Alpha - 20%
  *  Built out Splash Screen with animations
  *  Designed multiple levels
  *  Designed Level Pack Screen and Functionality
  *  Assisted with Core Data for Level storage
  
  Beta - (40%)
  *  Integrated Firebase functionality with application
  *  Created login page for application
  *  Created Firebase database to store user level progress and load it when the game starts
  
  Final - 10%
  *  Fixed bug with unlocking next level when next level button is not clicked 
  *  Added password checking for user creation
  
  #### Nirav Lalsinghani - NVL225 (17%)
  Alpha - 5%
  * Designed and Created App Icon Image
  * Added levels 7 and 8 Level Pack 1
  * Created TutorialViewController
  * Added how to play information for users
  
  Beta - 20%
  * Created Tutorial Mode that instructs players how to play the game
  * Designed beaver skins for the user to choose from
  
  Final - 25%
  * Level Pack 2 Level Design and Creation
  * Logout for Users
  * Bug fixes
  
### Differences 
  * Ranking/Scoring System - Ranking was initially going to be implemented through GameCenter, since dropping GameCenter it became much harder to implement. It was impractical to implement with Firebase, so we scrapped it.
  * Undo Functionality - After discussing, we have decided that having undo functionality makes the game too easy. Instead we implemented a level reset option, fully resetting the dam/level.
  

# DamIt README (Group 13)

## Comments
  * Please run this app/game on a real device to get the best performace. Any iOS device or model is supported.
  * Test account set up with progress of levels - username: test@gmail.com, password: test123
  * test account with all levels(so far) unlocked - username: he@gmail.com, password: test123
  * Known Bugs: When choosing a level pack, scrolling all the way to the right and then back to the left will cause levelpack buttons to become disabled
  * No levels past level pack 2, level 1 currently 

### Contributions
#### Kishan Solanki - KS46487 (25%):
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
  
#### Saigaurav Purushothaman - SP43976 (35%):
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
  
  #### Nikhil Bodicharla - NB24499 (25%):
   Alpha - 20%
  *  Built out Splash Screen with animations
  *  Designed multiple levels
  *  Designed Level Pack Screen and Functionality
  *  Assisted with Core Data for Level storage
  
  Beta - (40%)
  *  Integrated Firebase functionality with application
  *  Created login page for application
  *  Created Firebase database to store user level progress and load it when the game starts
  
  #### Nirav Lalsinghani - NVL225 (15%)
  Alpha - 5%
  * Designed and Created App Icon Image
  * Added levels 7 and 8 Level Pack 1
  * Created TutorialViewController
  * Added how to play information for users
Beta - 20%
  * Created tutorial feature that instruct players how to play the game
  * Designed beaver skins for the user to choose from
### Differences 
  * Ranking was initially going to be implemented through GameCenter, since dropping GameCenter it became much harder to implement some of that functionality. (Moving this implementation to final)
  * Undo Functionality - after discussing we have decided that having undo's makes the game to easy. For now we have a complete level reset option to the user if they get stuck on a level.
  

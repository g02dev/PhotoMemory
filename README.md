# PhotoMemory

## Brief description of the app
Play memory game on your phone in PhotoMemory app. Flip two card face up on each turn and find all pairs of matching cards.
The number of pairs varies depending on the selected difficulty. Adjust the difficulty and select one of predefined themes or create your own.

## Implementation
`Unsplash API` is used to let you find photos for creating your own theme. See `UnsplashClient`.    
`CoreData` is used to store themes created by the user. See `DataController`.   
`UserDefaults` is used to store preferred difficulty. See `Config`.  

`NewGameViewController` (entry point) - responsible for displaying the selected settings.  
`DifficultySelectionTableViewController` - responsible for the difficulty selection.  
`ThemeSelectionTableViewController` - responsible for the theme selection.  
`ThemeViewController` - responsible for the theme creation and editing.  
`ImageSearchViewController` - responsible for images search and selection.   
`GameViewController` - responsible for the game.  
`GameOverViewController` - responsible for displaying the final score when game is over.  

## Requirements
Xcode 12  
Swift 5

## Preview
#### Get ready for the game
![Settings](https://user-images.githubusercontent.com/58611737/129226809-d5954897-5434-471d-bac7-709ceb7f8425.gif)

#### Play
![Game](https://user-images.githubusercontent.com/58611737/129227052-7df45446-240f-4098-83fe-a8d37f9d8e8c.gif)

#### Add theme
![AddTheme](https://user-images.githubusercontent.com/58611737/129269853-aecf873c-dce8-4412-8586-cd02d3119ed1.gif)

#### Edit theme
![EditTheme](https://user-images.githubusercontent.com/58611737/129268800-f1205e4b-21f5-4afd-af50-8de0024b95d4.gif)

#### Delete theme
![DeleteTheme](https://user-images.githubusercontent.com/58611737/129270506-51b53604-d3fb-49f4-b08f-134fba9479d2.gif)


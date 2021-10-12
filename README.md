# PhotoMemory

## Description
Play memory game on your phone in PhotoMemory app. Flip two card face up on each turn and find all pairs of matching cards.
The number of pairs varies depending on the selected difficulty. Adjust the difficulty and select one of predefined themes or create your own.

Choose difficulty and set theme | Play
:-------------------------:|:-------------------------:
    <img src="https://user-images.githubusercontent.com/58611737/137030620-a508d6ad-6f7c-4471-8e29-d8d3785a60f8.gif" width="300"/>    |    <img src="https://user-images.githubusercontent.com/58611737/137028029-e3ec7fab-87e9-4fd5-9e20-9f855803fb31.gif" width="300"/>    

## Implementation
`Unsplash API` is used to let you find photos for creating your own theme. See `UnsplashClient`.    
`CoreData` is used to store themes created by the user. See `DataController`.   
`UserDefaults` is used to store preferred difficulty. See `Config`.    

## Requirements
Xcode 12
Swift 5

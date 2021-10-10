// 

import Foundation


struct Game {
    
    var numberOfPairs: Int
    
    var cards: [Card] = []
    
    var score: Int = 0
    
    var isFinished: Bool {
        return numberOfMatchedPairs == numberOfPairs
    }
    
    private var numberOfMatchedPairs: Int = 0
    
    private var indexOfFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairs: Int) {
        assert(numberOfPairs > 0, "MemoryGame.init(\(numberOfPairs)): 0 or less cards")
        
        self.numberOfPairs = numberOfPairs
        prepareForNewGame()
    }
    
    mutating func restart() {
        prepareForNewGame()
    }
    
    private mutating func prepareForNewGame() {
        score = 0
        numberOfMatchedPairs = 0
        setCards()
    }
    
    private mutating func setCards() {
        cards = []
        for _ in 1...numberOfPairs {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "MemoryGame.chooseCard(at: \(index)): chosen index not in the cards")

        if !cards[index].isMatched {
            if let matchIndex = indexOfFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    score += 2
                    numberOfMatchedPairs += 1
                } else {
                    score -= (cards[index].isVisited ? 1 : 0) + (cards[matchIndex].isVisited ? 1 : 0)
                }
                cards[index].isFaceUp = true
                cards[index].isVisited = true
            } else {
                indexOfFaceUpCard = index
            }
        }
    }

}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}


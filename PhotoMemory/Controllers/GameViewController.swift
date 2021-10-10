// 

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var yourScoreLabel: UILabel!
    
    @IBAction func restartGame(_ sender: Any) {
        restartGame()
    }
    
    private var game: Game!
    
    private var grid: BoundedGrid!
    
    private var imageChooser: CardImageChooser!
    
    private var numberOfPairs: Int {
        return Defaults.difficulty.numberOfPairs
    }
    
    private var numberOfCards: Int {
        return numberOfPairs * 2
    }
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGame()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        flowLayout.minimumLineSpacing = grid.spacing
        flowLayout.minimumInteritemSpacing = grid.spacing
        flowLayout.itemSize = CGSize(width: 10, height: 10)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        grid.updateFrame(collectionView.frame)
        flowLayout.itemSize = grid.cellSize
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateUI()
    }
    
    
    // MARK: - Methods
    
    private func updateUI() {
        yourScoreLabel.text = "your score: \(game.score)"
        collectionView.reloadData()
    }
    
    private func setupGame() {
        game = Game(numberOfPairs: numberOfPairs)
        grid = BoundedGrid(numberOfCells: numberOfCards, ratio: 1)
        imageChooser = CardImageChooser(theme: Defaults.theme)
    }
    
    private func restartGame() {
        setupGame()
        updateUI()
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.gameOver {
            let vc = segue.destination as! GameOverViewController
            vc.score = game.score
            restartGame()
        }
    }
    
}


extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfCards
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let card = game.cards[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseId.gameCardCell, for: indexPath) as! GameCardCollectionViewCell
        
        cell.image = imageChooser.image(for: card)
        cell.isFaceUp = card.isFaceUp
        cell.isMatched = card.isMatched
        
        return cell
    }
}


extension GameViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        game.chooseCard(at: indexPath.item)
        
        if game.isFinished {
            performSegue(withIdentifier: Constants.Segue.gameOver, sender: nil)
        } else {
            updateUI()
        }
    }
}

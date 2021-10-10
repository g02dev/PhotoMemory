// 

import UIKit

class GameOverViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var gameOverLabel: UILabel!
    
    @IBAction func handleRestart(_ sender: Any) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleNewGame(_ sender: Any) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.popToRootViewController(animated: true)
    }
    
    var score: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: true)
        
        let themeColor = Defaults.theme.color
        let buttons: [UIButton] = [restartButton, newGameButton]
        for button in buttons {
            button.layer.cornerRadius = Constants.UI.buttonCornerRadius
            button.backgroundColor = themeColor
        }
        gameOverLabel.textColor = themeColor
        scoreLabel.text = String(score)
    }
}

// 

import UIKit

class DifficultySelectionTableViewController: UITableViewController {
    
    private var selectedDifficulty: Difficulty {
        get {
            return Defaults.difficulty
        }
        set {
            Defaults.difficulty = newValue
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Difficulty.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let difficulty = Difficulty(rawValue: indexPath.row)!
        let isSelected = selectedDifficulty == difficulty
                
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReuseId.difficultyCell, for: indexPath)
        cell.textLabel?.text = difficulty.text
        cell.detailTextLabel?.text = "\(difficulty.numberOfPairs) pairs"
        cell.accessoryType = isSelected ? .checkmark : .none
        return cell
    }
    
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let difficulty = Difficulty(rawValue: indexPath.row)!
        selectedDifficulty = difficulty
    }
}

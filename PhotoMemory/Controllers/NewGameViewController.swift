// 

import UIKit

class NewGameViewController: UIViewController {
    
    // MARK: - IBOutlets and IBActions
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var startButton: UIButton!
    
    
    // MARK: - Constants and variables
    
    private let previewIndexPath = IndexPath(row: 0, section: 0)
    private let difficultyIndexPath = IndexPath(row: 0, section: 1)
    private let themeIndexPath = IndexPath(row: 1, section: 1)
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        startButton.layer.cornerRadius = Constants.UI.buttonCornerRadius
        startButton.backgroundColor = Defaults.theme.color
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUI()
    }
    
    private func updateUI() {
        startButton.backgroundColor = Defaults.theme.color
        tableView.reloadData()
    }
}


extension NewGameViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Preview"
        case 1:
            return "Settings"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let difficulty = Defaults.difficulty
        let theme = Defaults.theme
        
        switch indexPath {
        case previewIndexPath:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReuseId.previewCell) as! PreviewTableViewCell
            cell.difficulty = difficulty
            cell.themeColor = theme.color
            cell.photoImage = theme.coverImage
            return cell
        case difficultyIndexPath:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReuseId.settingCell)!
            cell.textLabel?.text = "Difficulty"
            cell.detailTextLabel?.text = difficulty.text
            return cell
        case themeIndexPath:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReuseId.settingCell)!
            cell.textLabel?.text = "Theme"
            cell.detailTextLabel?.text = theme.name
            return cell
        default:
            fatalError("Unknown cell")
        }
    }
}

extension NewGameViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 140 : 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        switch indexPath {
        case difficultyIndexPath:
            performSegue(withIdentifier: Constants.Segue.difficultySettings, sender: nil)
        case themeIndexPath:
            performSegue(withIdentifier: Constants.Segue.themeSettings, sender: nil)
        default:
            return
        }
    }
}

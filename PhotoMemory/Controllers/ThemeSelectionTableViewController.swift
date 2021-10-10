// 

import UIKit
import CoreData

class ThemeSelectionTableViewController: UITableViewController {
    
    // MARK: - Constants and variables
    
    private var fetchResultsController: NSFetchedResultsController<UserTheme>!
  
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 100
        setFetchResultController()
    }
    
    private func setFetchResultController() {
        fetchResultsController = Defaults.dataController.getUserThemesFetchedResultsController()
        fetchResultsController.delegate = self
        
        do {
            try fetchResultsController.performFetch()
        } catch {
            let alertTitle = Constants.Alert.userThemesLoadFailedTitle
            let alertImage = error.localizedDescription
            showAlert(title: alertTitle, message: alertImage)
        }
    }
    
    private func deleteUserTheme(_ userTheme: UserTheme) {
        Defaults.dataController.viewContext.delete(userTheme)
        try? Defaults.dataController.viewContext.saveIfNeeded()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return DefaultThemes.allCases.count
        case 1:
            return fetchResultsController.sections?[0].numberOfObjects ?? 0
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReuseId.themeCell, for: indexPath) as! ThemeTableViewCell
        
        switch indexPath.section {
        case 0:
            let theme = DefaultThemes.allCases[indexPath.row].theme
            cell.theme = theme
            cell.isSelectedTheme = theme == Defaults.theme
        case 1:
            let fetcherIndexPath = IndexPath(row: indexPath.row, section: 0)
            let theme = fetchResultsController.object(at: fetcherIndexPath).theme
            cell.theme = theme
            cell.isSelectedTheme = theme == Defaults.theme
        default:
            fatalError("Unknown section")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Default themes"
        case 1:
            return "My themes"
        default:
            return "Unknown"
        }
    }
    
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        switch indexPath.section {
        case 0:
            let newTheme = DefaultThemes.allCases[indexPath.row].theme
            Defaults.theme = newTheme
        case 1:
            let fetcherIndexPath = IndexPath(row: indexPath.row, section: 0)
            let userTheme = fetchResultsController.object(at: fetcherIndexPath)
            let newTheme = userTheme.theme
            Defaults.theme = newTheme
        default:
            return
        }
        
        tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        switch indexPath.section {
        case 1:
            let fetcherIndexPath = IndexPath(row: indexPath.row, section: 0)
            let userTheme = fetchResultsController.object(at: fetcherIndexPath)
            let contextItem = UIContextualAction(style: .normal, title: "Edit") { [unowned self] (_, _, completion) in
                self.performSegue(withIdentifier: Constants.Segue.theme, sender: userTheme)
            }
            let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
            return swipeActions
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        switch indexPath.section {
        case 1:
            
            let fetcherIndexPath = IndexPath(row: indexPath.row, section: 0)
            let userTheme = fetchResultsController.object(at: fetcherIndexPath)
            let contextItem = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] (_, cell, completion) in
                if Defaults.theme == userTheme.theme {
                    Defaults.theme = Constants.Settings.theme
                }
                self.deleteUserTheme(userTheme)
            }
            let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
            return swipeActions
        default:
            return nil
        }
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.theme {
            let userTheme = sender as? UserTheme
            let vc = segue.destination as! ThemeViewController
            vc.userTheme = userTheme
        }
    }
}


extension ThemeSelectionTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}

// 

import Foundation
import CoreData


class DataController {
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
}

extension DataController {
    func getUserThemesFetchedResultsController() -> NSFetchedResultsController<UserTheme> {
        let fetchRequest: NSFetchRequest<UserTheme> = UserTheme.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: Defaults.dataController.viewContext, sectionNameKeyPath: nil, cacheName: "themes")
        return fetchResultsController
    }
}

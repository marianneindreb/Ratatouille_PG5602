import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name: "MealModel")
        persistentContainer.loadPersistentStores {_, error in
        if let error = error {
            fatalError("Unresolved error \(error)")
        }
    }
    }
    
//    var viewContext: NSManagedObjectContext{
//        persistentContainer.viewContext
//    }
    
//    private lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "MealModel")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // TODO: 
    // fetching
    
    // Updating
    
    // deleting
    
}


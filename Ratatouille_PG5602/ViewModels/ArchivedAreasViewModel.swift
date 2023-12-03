import Foundation
import CoreData


class ArchivedAreasViewModel: ObservableObject {
    @Published var archivedAreas: [AreaModel] = []
    @Published var isLoading = false
    
    func getArchivedAreas() {
        self.isLoading = true
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<AreaEntity> = AreaEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isArchived == %@", NSNumber(value: true))

        do {
            let areasEntities = try context.fetch(fetchRequest)
            self.archivedAreas = areasEntities.map {
                AreaModel(flagURL: $0.flagURL ?? "", strArea: $0.strArea ?? "", isArchived: $0.isArchived)
            }
            self.isLoading = false
        } catch {
            print("Error fetching archived area: \(error)")
        }
    }
    
    func restoreArea(strArea: String) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<AreaEntity> = AreaEntity.fetchRequest()
        let predicate = NSPredicate(format: "strArea == %@", strArea)
        fetchRequest.predicate = predicate

        do {
            if let areaEntity = try context.fetch(fetchRequest).first {
                areaEntity.isArchived = false
                try context.save()
                print("Restored area \(strArea)")
                getArchivedAreas()
            }
        } catch {
            print("Error restoring area \(strArea): \(error)")
        }
    }
    
    func deleteArea(strArea: String) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<AreaEntity> = AreaEntity.fetchRequest()
        let predicate = NSPredicate(format: "strArea == %@", strArea)
        fetchRequest.predicate = predicate

        do {
            if let areaEntity = try context.fetch(fetchRequest).first {
                context.delete(areaEntity)
                try context.save()
                print("Deleted area \(strArea)")
                getArchivedAreas()
            }
        } catch {
            print("Error deleting area \(strArea): \(error)")
        }
    }
}

import CoreData
import Foundation
import SwiftUI

// @Observable
final class AreasViewModel: ObservableObject {
    @Published var areas: [AreaModel] = []
    @Published var meals: [MealListItemModel] = []
    
    enum LoadFrom {
        case API
        case coreData
    }
    
    private var countryCodes: [String: String] = [
        "American": "US",
        "British": "GB",
        "Canadian": "CA",
        "Chinese": "CN",
        "Croatian": "HR",
        "Dutch": "AN",
        "Egyptian": "EG",
        "Filipino": "PH",
        "French": "FR",
        "Greek": "GR",
        "Indian": "IN",
        "Irish": "IE",
        "Italian": "IT",
        "Jamaican": "JM",
        "Japanese": "JP",
        "Kenyan": "KE",
        "Malaysian": "MY",
        "Mexican": "MX",
        "Moroccan": "MA",
        "Polish": "PL",
        "Portuguese": "PT",
        "Russian": "RU",
        "Spanish": "ES",
        "Thai": "TH",
        "Tunisian": "TN",
        "Turkish": "TR",
        // TODO: placeholder image
        "Unknown": "",
        "Vietnamese": "VN",
    ]
    var onErrorHandling: ((Error) -> Void)?
    var onFetchCompleted: (() -> Void)?
    
    init(loadFrom: LoadFrom? = .API) {
        if loadFrom == LoadFrom.API {
            fetchAreasFromAPIAndSaveToCoreData()
        } else {
            loadAreasFromCoreData()
        }
    }
    
    func getAreas() -> [AreaModel] {
        if !areas.isEmpty {
            return areas
        } else {
            return getAreasFromCoreData()
        }
    }
    
    func loadAreasFromCoreData() {
        self.areas = getAreasFromCoreData()
    }
    
    func getAreasFromCoreData() -> [AreaModel] {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<AreaEntity> = AreaEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isArchived == %@", NSNumber(value: false))
        
        do {
            let areaEntities = try context.fetch(fetchRequest)
            if areaEntities.isEmpty {
                return []
            } else {
                let areasMapped = areaEntities.map {
                    AreaModel(strArea: $0.strArea ?? "", isArchived: $0.isArchived)
                }
                return areasMapped
            }
        } catch {
            print("Error fetching areas from Core Data: \(error)")
            return []
        }
    }
    
    func fetchAreasFromAPIAndSaveToCoreData() {
        print("Fetching areas from API and saving to coredata")
        areas.removeAll()
        let urlString = "https://www.themealdb.com/api/json/v1/1/list.php?a=list"
        NetworkManager.shared.fetchData(from: urlString) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let areaResponse = try JSONDecoder().decode(
                        AreasResponse.self,
                        from: data
                    )
                    DispatchQueue.main.async {
                        self?.areas = areaResponse.meals
                        self?.saveAreasToCoreData()
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.onErrorHandling?(error)
                    }
                }
            case .failure(let error):
                self?.onErrorHandling?(error)
            }
        }
    }
    
    func fetchMealsFromAPI(forArea area: String) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?a=\(area)"
        NetworkManager.shared.fetchData(from: urlString) { [weak self] result in
            switch result {
            case .success(let data):
                self?.parseMealDataAndSetVariable(data)
            case .failure(let error):
                self?.onErrorHandling?(error)
            }
        }
    }
    
    private func parseMealDataAndSetVariable(_ data: Data) {
        do {
            let mealResponse = try JSONDecoder().decode(MealListItemResponse.self, from: data)
            DispatchQueue.main.async {
                self.meals = mealResponse.meals
                self.onFetchCompleted?()
            }
        } catch {
            DispatchQueue.main.async {
                self.onErrorHandling?(error)
            }
        }
    }
    
    func getMealsFromCoreData(forArea area: String) -> [MealEntity]? {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "strArea == %@", areas)
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching meals from area: \(area) from Core Data: \(error)")
            return nil
        }
    }
    
    func archiveArea(strArea: String) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<AreaEntity> = AreaEntity.fetchRequest()
        let predicate = NSPredicate(format: "strArea == %@", strArea)
        fetchRequest.predicate = predicate
        do {
            if let areaEntity = try context.fetch(fetchRequest).first {
                areaEntity.isArchived = true
                try context.save()
                print("Archived area \(strArea)")
                loadAreasFromCoreData()
            }
        } catch {
            print("Error archiving area \(strArea): \(error)")
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
                loadAreasFromCoreData()
            }
        } catch {
            print("Error restoring area \(strArea): \(error)")
        }
    }
    
    func updateArea(strArea: String, newName: String){
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<AreaEntity> = AreaEntity.fetchRequest()
        let predicate = NSPredicate(format: "strArea == %@", strArea)
        fetchRequest.predicate = predicate

        do {
            if let areaEntity = try context.fetch(fetchRequest).first {
                areaEntity.strArea = newName
               
                try context.save()
                print("Updated area from \(strArea) to \(newName)")
                self.loadAreasFromCoreData()
            }
        } catch {
            print("Error updating area name \(strArea) to \(newName): \(error)")
        }
    }
}

// flagURL: $0.flagURL ?? "",

extension AreasViewModel {
    func saveAreasToCoreData() {
        guard areas.count > 0 else {
            return
        }
        
        let context = CoreDataManager.shared.context
        for area in areas {
            let areaEntity = AreaEntity(context: context)
            areaEntity.strArea = area.strArea
            areaEntity.isArchived = false
            let countryCode = countryCodes[area.strArea] ?? ""
            areaEntity.flagURL = (countryCode.isEmpty) ? "" : "https://flagsapi.com/\(countryCode)/shiny/64.png"
        }
        do {
            try context.save()
        } catch {
            print("Error")
        }
    }

    private func deleteAllAreas(in context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = AreaEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Error deleting existing areas: \(error), \(error.userInfo)")
        }
    }
}

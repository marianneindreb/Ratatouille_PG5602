import Foundation
import CoreData

class AreasViewModel: ObservableObject {
    @Published var areas: [AreaModel] = []
    @Published var meals: [MealListItemModel] = []
    
    private var countryCodes: Dictionary<String, String> = [
        "American": "US",
        "British" : "GB",
        "Canadian" : "CA",
        "Chinese" : "CN",
        "Croatian" : "HR",
        "Dutch" : "AN",
        "Egyptian" : "EG",
        "Filipino" : "PH",
        "French" : "FR",
        "Greek" : "GR",
        "Indian" : "IN",
        "Irish" : "IE",
        "Italian" : "IT",
        "Jamaican" : "JM",
        "Japanese" : "JP",
        "Kenyan" : "KE",
        "Malaysian" : "MY",
        "Mexican" : "MX",
        "Moroccan" : "MA",
        "Polish" : "PL",
        "Portuguese" : "PT",
        "Russian" : "RU",
        "Spanish" : "ES",
        "Thai" : "TH",
        "Tunisian" : "TN",
        "Turkish" : "TR",
        //TODO: placeholder image
        "Unknown" : "",
        "Vietnamese" : "VN",
    ]
    var onErrorHandling: ((Error) -> Void)?
    var onFetchCompleted: (() -> Void)?
    
    init() {
        getAreasFromCoreDataIfNeeded()
    }
    
    func getAreasFromCoreDataIfNeeded() {
        if areas.isEmpty {
            getAreasFromCoreData()
        }
    }
    
    func fetchAreas() {
        let urlString = "https://www.themealdb.com/api/json/v1/1/list.php?a=list"
        NetworkManager.shared.fetchData(from: urlString) { [weak self] result in
            switch result {
            case .success(let data):
                self?.parseAreaData(data)
            case .failure(let error):
                self?.onErrorHandling?(error)
            }
        }
    }
    
    func fetchMeals(forArea area: String) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?a=\(area)"
        NetworkManager.shared.fetchData(from: urlString) { [weak self] result in
            switch result {
            case .success(let data):
                self?.parseMealData(data)
            case .failure(let error):
                self?.onErrorHandling?(error)
            }
        }
    }

    private func parseMealData(_ data: Data) {
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
    
    
    func getAreasFromCoreData() {
            let context = CoreDataManager.shared.context
            let fetchRequest: NSFetchRequest<AreaEntity> = AreaEntity.fetchRequest()

            do {
                let areasEntities = try context.fetch(fetchRequest)
                self.areas = areasEntities.map { AreaModel(strArea: $0.strArea ?? "") }
            } catch {
                print("Error fetching areas from Core Data: \(error)")
            }
        }
    // flagURL: $0.flagURL ?? "", 
    
    private func parseAreaData(_ data: Data) {
        do {
            let areaResponse = try JSONDecoder().decode(AreasResponse.self, from: data)
            DispatchQueue.main.async {
                self.areas = areaResponse.meals
                self.onFetchCompleted?()
            }
        } catch {
            DispatchQueue.main.async {
                self.onErrorHandling?(error)
            }
        }
    }
    
    var numberOfAreas: Int {
        return areas.count
    }
    
    func area(at index: Int) -> AreaModel? {
        guard index >= 0 && index < areas.count else {
            return nil
        }
        return areas[index]
    }
}

extension AreasViewModel {
    func saveAreasToCoreData() {
        guard areas.count > 0 else {
            return
        }
        
        let context = CoreDataManager.shared.context
        for area in areas {
            let areaEntity = AreaEntity(context: context)
            areaEntity.strArea = area.strArea
            
            
            //            let countryCode = countryCodes[area.strArea] ?? "";
            //            areaEntity.flagURL = (countryCode.isEmpty) ? "" : "https://flagsapi.com/\(countryCode)/shiny/64.png"
        }
        do {
            try context.save()
        } catch {
            print("Error")
        }
        // TODO: 
    // handle optionals
        
      //  CoreDataManager.shared.saveContext()
    }
    
    // Get areas from coredata?

    private func deleteAllAreas(in context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = AreaEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Error deleting existing records: \(error), \(error.userInfo)")
        }
    }
}





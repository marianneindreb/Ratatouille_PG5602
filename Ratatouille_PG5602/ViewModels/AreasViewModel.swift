import Foundation
import CoreData
import SwiftUI

//@Observable
final class AreasViewModel: ObservableObject {
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
        self.fetchAreasFromAPIAndSaveToCoreData()
    }
    
    func getAreas() -> [AreaModel] {
        if !self.areas.isEmpty {
            return self.areas
        } else {
            return getAreasFromCoreData()
        }
    }
    
    
    func getAreasFromCoreData() -> [AreaModel] {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<AreaEntity> = AreaEntity.fetchRequest()
        
        do {
            let areaEntities = try context.fetch(fetchRequest)
            if areaEntities.isEmpty {
                return []
            } else {
                let areasMapped = areaEntities.map {
                    AreaModel(strArea: $0.strArea ?? "")
                }
                return areasMapped;
            }
        } catch {
            print("Error fetching areas from Core Data: \(error)")
            return []
        }
    }
    
    
    func fetchAreasFromAPIAndSaveToCoreData() {
        print("Fetching areas from API and saves to coredata")
        self.areas.removeAll()
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
    
    func fetchMeals(forArea area: String) {
        if let fetchedMeals = getMealsFromCoreData(forArea: area), !fetchedMeals.isEmpty {
            self.meals = fetchedMeals.map { MealListItemModel(from: $0) }
        } else {
            fetchMealsFromAPI(forArea: area)
        }
    }
    
    func fetchMealsFromAPI(forArea area: String) {
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
    
    
    func getMealsFromCoreData(forArea area: String) -> [MealEntity]? {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "strArea == %@", areas )
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching meals from area: \(area) from Core Data: \(error)")
            return nil
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
            
            
            //            let countryCode = countryCodes[area.strArea] ?? "";
            //            areaEntity.flagURL = (countryCode.isEmpty) ? "" : //"https://flagsapi.com/\(countryCode)/shiny/64.png"
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





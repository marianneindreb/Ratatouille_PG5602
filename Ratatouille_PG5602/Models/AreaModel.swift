import Foundation

struct AreaModel: Decodable, Hashable {
    
    let flagURL: String?
    let strArea: String
    var isArchived: Bool? = false
    //var id: String {strArea}
}

struct AreasResponse: Decodable {
    let meals: [AreaModel]
}



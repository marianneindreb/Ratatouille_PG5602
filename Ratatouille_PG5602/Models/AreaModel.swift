import Foundation

struct AreaModel: Decodable, Hashable, Identifiable {
    //let flagURL: String
    let strArea: String
    var id: String {strArea}
}

struct AreasResponse: Decodable {
    let meals: [AreaModel]
}



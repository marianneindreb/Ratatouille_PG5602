import Foundation

struct CategoryModel: Decodable {
    let strCategory: String
    var isArchived: Bool? = false
}

struct CategoriesResponse: Decodable {
    let meals: [CategoryModel]
}

import Foundation

struct CategoryModel: Decodable {
    let strCategory: String
}

struct CategoriesResponse: Decodable {
    let meals: [CategoryModel]
}

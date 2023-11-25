import Foundation

struct CategoryModel: Decodable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
   
}

struct CategoriesResponse: Decodable {
    let categories: [CategoryModel]
}

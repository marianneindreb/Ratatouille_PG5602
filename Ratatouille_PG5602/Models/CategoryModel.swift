//
//  CategoryModel.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 21/11/2023.
//

import Foundation

struct Category: Decodable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
   
}

struct CategoryResponse: Decodable {
    let categories: [Category]
}

// https://www.themealdb.com/api/json/v1/1/categories.php

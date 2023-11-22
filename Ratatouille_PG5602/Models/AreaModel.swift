//
//  AreaModel.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 21/11/2023.
//

import Foundation

struct AreaModel: Decodable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String?
}

struct AreaResponse: Decodable {
    let categories: [AreaModel]
}



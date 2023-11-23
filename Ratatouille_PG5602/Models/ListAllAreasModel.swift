//
//  ListAllAreasModel.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 23/11/2023.
//

import Foundation
struct ListAllAreasModel: Decodable {
    let strArea: String
   
}

struct ListAllAreasResponse: Decodable {
    let meals: [ListAllAreasModel]
}

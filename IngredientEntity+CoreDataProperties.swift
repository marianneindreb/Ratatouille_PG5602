//
//  IngredientEntity+CoreDataProperties.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 22/11/2023.
//
//

import Foundation
import CoreData


extension IngredientEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IngredientEntity> {
        return NSFetchRequest<IngredientEntity>(entityName: "IngredientEntity")
    }

    @NSManaged public var ingredient_id: Int32
    @NSManaged public var ingredient_name: String?

}

extension IngredientEntity : Identifiable {

}

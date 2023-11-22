//
//  CategoryEntity+CoreDataProperties.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 22/11/2023.
//
//

import Foundation
import CoreData


extension CategoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryEntity> {
        return NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
    }

    @NSManaged public var category_id: Int32
    @NSManaged public var category_name: String?
    @NSManaged public var meal: MealEntity?

}

extension CategoryEntity : Identifiable {

}

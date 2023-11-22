//
//  MealEntity+CoreDataProperties.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 22/11/2023.
//
//

import Foundation
import CoreData


extension MealEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealEntity> {
        return NSFetchRequest<MealEntity>(entityName: "MealEntity")
    }

    @NSManaged public var meal_id: Int32
    @NSManaged public var meal_name: String?
    @NSManaged public var area_id: Int32
    @NSManaged public var category_id: Int32
    @NSManaged public var archived: Bool
    @NSManaged public var area: AreaEntity?
    @NSManaged public var categoory: CategoryEntity?

}

extension MealEntity : Identifiable {

}

//
//  AreaEntity+CoreDataProperties.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 22/11/2023.
//
//

import Foundation
import CoreData


extension AreaEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AreaEntity> {
        return NSFetchRequest<AreaEntity>(entityName: "AreaEntity")
    }

    @NSManaged public var area_name: String?
    @NSManaged public var area_id: Int32
    @NSManaged public var meal: MealEntity?

}

extension AreaEntity : Identifiable {

}

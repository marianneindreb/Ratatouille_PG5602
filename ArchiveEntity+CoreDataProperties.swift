//
//  ArchiveEntity+CoreDataProperties.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 22/11/2023.
//
//

import Foundation
import CoreData


extension ArchiveEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArchiveEntity> {
        return NSFetchRequest<ArchiveEntity>(entityName: "ArchiveEntity")
    }

    @NSManaged public var archive_id: Int32
    @NSManaged public var table_name: String?
    @NSManaged public var record_id: Int32

}

extension ArchiveEntity : Identifiable {

}

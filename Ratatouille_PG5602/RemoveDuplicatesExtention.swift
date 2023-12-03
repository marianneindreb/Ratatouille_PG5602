//
//  RemoveDuplicatesExtention.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 03/12/2023.
//

import Foundation

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
}

//
//  Item.swift
//  TakeAChanceOnMe
//
//  Created by Michael Fluharty on 10/3/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

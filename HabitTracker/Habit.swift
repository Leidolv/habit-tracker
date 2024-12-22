//
//  Item.swift
//  HabitTracker
//
//  Created by Aknazar Sherniiazov on 8/12/24.
//

import Foundation
import SwiftData

@Model
final class Habit {
    var name: String
    var timestamp: Date
    var progress: Int
    
    init(name: String, timestamp: Date, progress: Int = 0) {
        self.name = name
        self.timestamp = timestamp
        self.progress = progress
    }
}

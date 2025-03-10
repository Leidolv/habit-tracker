//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Aknazar Sherniiazov on 8/12/24.
//

import SwiftUI
import SwiftData

@main
struct HabitTrackerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([Habit.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            print("⚠️ Error creating ModelContainer: \(error.localizedDescription)")
            do {
                return try ModelContainer(for: schema, configurations: [ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)])
            } catch {
                fatalError("❌ Critical error: Failed to create even an in-memory ModelContainer. \(error.localizedDescription)")
            }
        }
    }()



    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}

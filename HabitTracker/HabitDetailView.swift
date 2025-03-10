//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Aknazar Sherniiazov on 10/3/25.
//

import Foundation

import SwiftUI
import SwiftData

struct HabitDetailView: View {
    let habit: Habit

    var body: some View {
        VStack(alignment: .leading) {
            Text("Habit: \(habit.name)").font(.title)
            Text("Created on: \(habit.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
            Text("Progress: \(habit.progress)")
            Button("Increase Progress") {
                habit.progress += 1
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .padding()
        .navigationTitle(habit.name)
    }
}

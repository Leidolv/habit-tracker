//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Aknazar Sherniiazov on 10/3/25.
//

import Foundation

import SwiftUI
import SwiftData

struct AddHabitView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var isPresented: Bool
    @State private var newHabitName = ""

    var body: some View {
        VStack {
            Text("Add a New Habit")
                .font(.headline)
            
            TextField("Habit name", text: $newHabitName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save") {
                saveHabit()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .padding()
    }

    private func saveHabit() {
        let trimmedName = newHabitName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else {
            print("⚠️ Habit name cannot be empty")
            return
        }

        withAnimation {
            let newHabit = Habit(name: trimmedName, timestamp: Date())
            modelContext.insert(newHabit)
            isPresented = false
            newHabitName = ""
        }
    }
}

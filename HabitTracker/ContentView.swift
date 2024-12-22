//
//  ContentView.swift
//  HabitTracker
//
//  Created by Aknazar Sherniiazov on 8/12/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Habit]
    
    @State private var showAddHabit = false
    @State private var newHabitName = ""

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { habit in
                    NavigationLink {
                        VStack(alignment: .leading) {
                            Text("Habit: \(habit.name)").font(.title)
                            Text("Created on: \(habit.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                            Text("Progress: \(habit.progress)")
                        }
                        .padding()
                    } label: {
                        VStack(alignment: .leading) {
                            Text(habit.name).font(.headline)
                            Text("Progress: \(habit.progress)").font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Habit", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select a habit")
        }
        .sheet(isPresented: $showAddHabit) {
            VStack {
                Text("Add a New Habit").font(.headline)
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
    }

    private func addItem() {
        showAddHabit = true
        }

    private func saveHabit() {
        withAnimation {
            let newHabit = Habit(name: newHabitName, timestamp: Date())
            modelContext.insert(newHabit)
            showAddHabit = false
            newHabitName = ""
        }
    }
    

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Habit.self, inMemory: true)
}

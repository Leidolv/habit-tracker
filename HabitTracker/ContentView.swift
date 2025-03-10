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

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { habit in
                    NavigationLink {
                        HabitDetailView(habit: habit)
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(habit.name).font(.headline)
                                Text("Progress: \(habit.progress)").font(.subheadline)
                            }
                            Spacer()
                            Button {
                                increaseProgress(for: habit)
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                            .buttonStyle(.borderless)
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
                    Button(action: { showAddHabit = true }) {
                        Label("Add Habit", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select a habit")
        }
        .sheet(isPresented: $showAddHabit) {
            AddHabitView(isPresented: $showAddHabit)
        }
    }

    private func increaseProgress(for habit: Habit) {
        withAnimation {
            habit.progress += 1
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
